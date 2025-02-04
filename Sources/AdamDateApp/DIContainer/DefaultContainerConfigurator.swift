//
//  DefaultContainerConfigurator.swift
//  AdamDateAPI
//
//  Created by Adam Young on 09/01/2025.
//

import AdamDateAuth
import Fluent
import Foundation
import Vapor

final class DefaultContainerConfigurator: ContainerConfigurator {

    private let c: Container
    private let databases: [DatabaseID: any Database]
    private let jwtConfiguration: JWTConfiguration
    private let passwordHasher: PasswordHasher

    init(
        container: Container,
        databases: [DatabaseID: any Database],
        jwtConfiguration: JWTConfiguration,
        passwordHasher: PasswordHasher
    ) {
        self.c = container
        self.databases = databases
        self.jwtConfiguration = jwtConfiguration
        self.passwordHasher = passwordHasher
    }

    func configure() {
        configureAuth()
        configureIdentity()
        configureProfile()
        configureReferenceData()
    }

}

extension DefaultContainerConfigurator {

    private func configureAuth() {
        let configurator = AdamDateAuthContainerConfigurator(
            container: c,
            jwtConfiguration: jwtConfiguration
        )
        configurator.configure()
    }

    private func configureIdentity() {
        guard let database = databases[DatabaseID.identity] else {
            fatalError("Database \(DatabaseID.identity.string) not configured")
        }

        let configurator = DefaultIdentityContainerConfigurator(
            container: c,
            database: database,
            passwordHasher: passwordHasher
        )
        configurator.configure()
    }

    private func configureProfile() {
        guard let database = databases[DatabaseID.profile] else {
            fatalError("Database \(DatabaseID.profile.string) not configured")
        }

        let configurator = DefaultProfileContainerConfigurator(
            container: c,
            database: database
        )
        configurator.configure()
    }

    private func configureReferenceData() {
        let configurator = DefaultReferenceDataContainerConfigurator(container: c)
        configurator.configure()
    }

}
