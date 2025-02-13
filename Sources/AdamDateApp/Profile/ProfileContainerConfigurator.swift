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
            ProfileInfrastructureFactory.makeBasicProfileRepository(
                database: c.resolve(Database.self, name: DatabaseID.profile.string)
            )
        }

        c.register(type: BasicInfoRepository.self) { c in
            ProfileInfrastructureFactory.makeBasicInfoRepository(
                database: c.resolve(Database.self, name: DatabaseID.profile.string)
            )
        }

        c.register(type: UserService.self) { c in
            ProfileUserServiceAdapter(
                fetchUserUseCase: { [c] in c.resolve(FetchUserUseCase.self) }
            )
        }

        c.register(type: CountryService.self) { c in
            ProfileCountryServiceAdapter(
                fetchCountryUseCase: { [c] in c.resolve(FetchCountryUseCase.self) }
            )
        }

        c.register(type: GenderService.self) { c in
            ProfileGenderServiceAdapter(
                fetchGenderUseCase: { [c] in c.resolve(FetchGenderUseCase.self) }
            )
        }
    }

    private func configureApplication(in c: Container) {
        c.register(type: FetchProfileUseCase.self) { c in
            ProfileApplicationFactory.makeFetchProfileUseCase(
                basicProfileRepository: c.resolve(BasicProfileRepository.self),
                basicInfoRepository: c.resolve(BasicInfoRepository.self)
            )
        }

        c.register(type: CreateBasicProfileUseCase.self) { c in
            ProfileApplicationFactory.makeCreateBasicProfileUseCase(
                repository: c.resolve(BasicProfileRepository.self),
                userService: c.resolve(UserService.self)
            )
        }

        c.register(type: FetchBasicProfileUseCase.self) { c in
            ProfileApplicationFactory.makeFetchBasicProfileUseCase(
                repository: c.resolve(BasicProfileRepository.self)
            )
        }

        c.register(type: CreateBasicInfoUseCase.self) { c in
            ProfileApplicationFactory.makeCreateBasicInfoUseCase(
                repository: c.resolve(BasicInfoRepository.self),
                userService: c.resolve(UserService.self),
                countryService: c.resolve(CountryService.self),
                genderService: c.resolve(GenderService.self)
            )
        }

        c.register(type: FetchBasicInfoUseCase.self) { c in
            ProfileApplicationFactory.makeFetchBasicInfoUseCase(
                repository: c.resolve(BasicInfoRepository.self)
            )
        }
    }

    private func configurePresentation(in c: Container) {
        c.register(type: RouteCollection.self, name: "ProfileController") { c in
            ProfilePresentationFactory.makeProfileController(
                fetchProfileUseCase: { [c] in c.resolve(FetchProfileUseCase.self) }
            )
        }

        c.register(type: RouteCollection.self, name: "BasicProfileController") { c in
            ProfilePresentationFactory.makeBasicProfileController(
                createBasicProfileUserCase: { [c] in c.resolve(CreateBasicProfileUseCase.self) },
                fetchBasicProfileUseCase: { [c] in c.resolve(FetchBasicProfileUseCase.self) }
            )
        }

        c.register(type: RouteCollection.self, name: "BasicInfoController") { c in
            ProfilePresentationFactory.makeBasicInfoController(
                createBasicInfoUseCase: { [c] in c.resolve(CreateBasicInfoUseCase.self) },
                fetchBasicInfoUseCase: { [c] in c.resolve(FetchBasicInfoUseCase.self) },
                fetchBasicProfileUseCase: { [c] in c.resolve(FetchBasicProfileUseCase.self) }
            )
        }
    }

}
