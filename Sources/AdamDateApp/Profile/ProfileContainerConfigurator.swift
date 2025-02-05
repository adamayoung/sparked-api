//
//  ProfileContainerConfigurator.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Fluent
import Foundation
import IdentityApplication
import ProfileApplication
import ProfileDomain
import ProfileInfrastructure
import ProfilePresentation
import ReferenceDataApplication
import Vapor

final class ProfileContainerConfigurator: ContainerConfigurator {

    private let database: any Database

    init(database: some Database) {
        self.database = database
    }

    func configure(in c: Container) {
        configureInfrastructure(in: c)
        configureApplication(in: c)
        configurePresentation(in: c)
    }

}

extension ProfileContainerConfigurator {

    private func configureInfrastructure(in c: Container) {
        c.register(type: Database.self, name: DatabaseID.profile.string) { [database] _ in
            database
        }

        c.register(type: BasicProfileRepository.self) { c in
            BasicProfileFluentRepository(
                database: c.resolve(Database.self, name: DatabaseID.profile.string)
            )
        }

        c.register(type: GenderService.self) { c in
            ProfileGenderAdapter(fetchGendersUseCase: c.resolve(FetchGendersUseCase.self))
        }

        c.register(type: CountryService.self) { c in
            ProfileCountryAdapter(fetchCountriesUseCase: c.resolve(FetchCountriesUseCase.self))
        }

        c.register(type: UserService.self) { c in
            ProfileUserAdapter(fetchUserUseCase: c.resolve(FetchUserUseCase.self))
        }
    }

    private func configureApplication(in c: Container) {
        c.register(type: CreateBasicProfileUseCase.self) { c in
            CreateBasicProfile(
                repository: c.resolve(BasicProfileRepository.self),
                userService: c.resolve(ProfileUserAdapter.self)
            )
        }

        c.register(type: FetchBasicProfileUseCase.self) { c in
            FetchBasicProfile(
                repository: c.resolve(BasicProfileRepository.self)
            )
        }
    }

    private func configurePresentation(in c: Container) {
        c.register(type: BasicProfileController.self) { c in
            BasicProfileController(
                createBasicProfileUseCase: { [c] in c.resolve(CreateBasicProfileUseCase.self) },
                fetchBasicProfileUseCase: { [c] in c.resolve(FetchBasicProfileUseCase.self) }
            )
        }
    }

}
