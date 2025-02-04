//
//  DefaultProfileContainerConfigurator.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Fluent
import Foundation
import ProfileAPI
import ProfileDomain
import ProfileInfrastructure
import ReferenceDataDomain
import Vapor

final class DefaultProfileContainerConfigurator: ContainerConfigurator {

    private let c: Container
    private let database: any Database

    init(
        container: Container,
        database: some Database
    ) {
        self.c = container
        self.database = database
    }

    func configure() {
        configureDatabases()
        configureProviders()
        configureRepositories()
        configureUseCases()
        configureControllers()
    }

}

extension DefaultProfileContainerConfigurator {

    private func configureDatabases() {
        c.register(type: Database.self, name: DatabaseID.profile.string) { [database] _ in
            database
        }
    }

    private func configureProviders() {
        c.register(type: GenderProvider.self) { c in
            ProfileGenderAdapter(fetchGendersUseCase: c.resolve(FetchGendersUseCase.self))
        }
    }

    private func configureRepositories() {
        c.register(type: BasicProfileRepository.self) { c in
            BasicProfileFluentRepository(
                database: c.resolve(Database.self, name: DatabaseID.profile.string)
            )
        }
    }

    private func configureUseCases() {
        c.register(type: CreateBasicProfileUseCase.self) { c in
            CreateBasicProfile(
                repository: c.resolve(BasicProfileRepository.self)
            )
        }

        c.register(type: FetchBasicProfileUseCase.self) { c in
            FetchBasicProfile(
                repository: c.resolve(BasicProfileRepository.self)
            )
        }
    }

    private func configureControllers() {
        c.register(type: BasicProfileController.self) { c in
            BasicProfileController(
                createBasicProfileUseCase: { [c] in c.resolve(CreateBasicProfileUseCase.self) },
                fetchBasicProfileUseCase: { [c] in c.resolve(FetchBasicProfileUseCase.self) }
            )
        }
    }

}
