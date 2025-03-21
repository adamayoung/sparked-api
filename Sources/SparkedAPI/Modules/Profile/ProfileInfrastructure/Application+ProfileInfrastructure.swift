//
//  Application+ProfileInfrastructure.swift
//  SparkedAPI
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
            database: self.db(DatabaseID.sparked)
        )
    }

    var basicInfoRepository: any BasicInfoRepository {
        ProfileInfrastructureFactory.makeBasicInfoRepository(
            database: self.db(DatabaseID.sparked)
        )
    }

    var extendedInfoRepository: any ExtendedInfoRepository {
        ProfileInfrastructureFactory.makeExtendedInfoRepository(
            database: self.db(DatabaseID.sparked)
        )
    }

    var profilePhotoRepository: any ProfilePhotoRepository {
        ProfileInfrastructureFactory.makeProfilePhotoRepository(
            database: self.db(DatabaseID.sparked)
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
            database: self.db(DatabaseID.sparked)
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

    var profileEducationLevelRepository: any ProfileApplication.EducationLevelRepository {
        ProfileInfrastructureFactory.makeEducationLevelRepository(
            educationLevelService: ProfileAdapterFactory.makeEducationLevelService(
                fetchEducationLevelUseCase:
                    ReferenceDataApplicationFactory.makeFetchEducationLevelUseCase(
                        educationLevelRepository: self.educationLevelRepository
                    )
            )
        )
    }

    var profileStarSignRepository: any ProfileApplication.StarSignRepository {
        ProfileInfrastructureFactory.makeStarSignRepository(
            starSignService: ProfileAdapterFactory.makeStarSignService(
                fetchStarSignUseCase: ReferenceDataApplicationFactory.makeFetchStarSignUseCase(
                    starSignRepository: self.starSignRepository
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
