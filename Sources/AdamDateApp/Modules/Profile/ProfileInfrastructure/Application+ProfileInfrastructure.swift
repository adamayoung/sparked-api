//
//  Application+ProfileInfrastructure.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import Fluent
import Foundation
import IdentityApplication
import ProfileApplication
import ProfileInfrastructure
import ProfileWebAPI
import ReferenceDataApplication
import Vapor

extension Application {

    var basicProfileRepository: any BasicProfileRepository {
        ProfileInfrastructureFactory.makeBasicProfileRepository(
            database: self.db(DatabaseID.adamDate)
        )
    }

    var basicInfoRepository: any BasicInfoRepository {
        ProfileInfrastructureFactory.makeBasicInfoRepository(
            database: self.db(DatabaseID.adamDate)
        )
    }

    var profilePhotoRepository: any ProfilePhotoRepository {
        ProfileInfrastructureFactory.makeProfilePhotoRepository(
            database: self.db(DatabaseID.adamDate)
        )
    }

    var imageRepository: any ImageRepository {
        ProfileInfrastructureFactory.makeImageRepository(
            fileStorageService: ProfileAdapterFactory.makeProfileFileStorageService(
                fileStorage: self.fileStorage,
                containerName: "profile"
            )
        )
    }

    var profileInterestRepository: any ProfileApplication.ProfileInterestRepository {
        ProfileInfrastructureFactory.makeProfileInterestRepository(
            database: self.db(DatabaseID.adamDate)
        )
    }

    var profileCountryRepository: any ProfileApplication.CountryRepository {
        ProfileInfrastructureFactory.makeCountryRepository(
            countryService: ProfileAdapterFactory.makeCountryService(
                fetchCountryUseCase: ReferenceDataApplicationFactory.makeFetchCountryUseCase(
                    countryRepository: self.countryRepository
                )
            )
        )
    }

    var profileGenderRepository: any ProfileApplication.GenderRepository {
        ProfileInfrastructureFactory.makeGenderRepository(
            genderService: ProfileAdapterFactory.makeGenderService(
                fetchGenderUseCase: ReferenceDataApplicationFactory.makeFetchGenderUseCase(
                    genderRepository: self.genderRepository
                )
            )
        )
    }

    var profileModuleInterestRepository: any ProfileApplication.InterestRepository {
        ProfileInfrastructureFactory.makeInterestRepository(
            interestService: ProfileAdapterFactory.makeInterestService(
                fetchInterestUseCase: ReferenceDataApplicationFactory.makeFetchInterestUseCase(
                    interestRepository: self.interestRepository
                )
            )
        )
    }

    var profileUserRepository: any ProfileApplication.UserRepository {
        ProfileInfrastructureFactory.makeUserRepository(
            userService: ProfileAdapterFactory.makeUserService(
                fetchUserUseCase: IdentityApplicationFactory.makeFetchUserUseCase(
                    repository: self.userRepository,
                    roleRepository: self.roleRepository
                )
            )
        )
    }

}
