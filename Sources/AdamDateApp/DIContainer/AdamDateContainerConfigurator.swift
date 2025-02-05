//
//  DefaultContainerConfigurator.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import AdamDateAuth
import Fluent
import Foundation
import Vapor

final class AdamDateContainerConfigurator: ContainerConfigurator {

    private let databases: [DatabaseID: any Database]
    private let jwtConfiguration: JWTConfiguration
    private let passwordHasher: PasswordHasher

    init(
        databases: [DatabaseID: any Database],
        jwtConfiguration: JWTConfiguration,
        passwordHasher: PasswordHasher
    ) {
        self.databases = databases
        self.jwtConfiguration = jwtConfiguration
        self.passwordHasher = passwordHasher
    }

    func configure(in c: Container) {
        configureAuth(in: c)
        configureIdentity(in: c)
        configureProfile(in: c)
        configureReferenceData(in: c)
    }

}

extension AdamDateContainerConfigurator {

    private func configureAuth(in c: Container) {
        let configurator = AdamDateAuthContainerConfigurator(
            jwtConfiguration: jwtConfiguration
        )
        c.configure(with: configurator)
    }

    private func configureIdentity(in c: Container) {
        guard let database = databases[DatabaseID.identity] else {
            fatalError("Database \(DatabaseID.identity.string) not configured")
        }

        let configurator = IdentityContainerConfigurator(
            database: database,
            passwordHasher: passwordHasher
        )
        c.configure(with: configurator)
    }

    private func configureProfile(in c: Container) {
        guard let database = databases[DatabaseID.profile] else {
            fatalError("Database \(DatabaseID.profile.string) not configured")
        }

        let configurator = ProfileContainerConfigurator(database: database)
        c.configure(with: configurator)
    }

    private func configureReferenceData(in c: Container) {
        guard let database = databases[DatabaseID.referenceData] else {
            fatalError("Database \(DatabaseID.referenceData.string) not configured")
        }

        let configurator = ReferenceDataContainerConfigurator(database: database)
        c.configure(with: configurator)
    }

}
