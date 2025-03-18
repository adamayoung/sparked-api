//
//  ProfileUsesCasesProvider.swift
//  AdamDateApp
//
//  Created by Adam Young on 13/02/2025.
//

import Foundation
import IdentityApplication
import ProfileApplication
import ProfileWebAPI
import ReferenceDataApplication
import Vapor

extension Application.ProfileWebAPIUseCases.Provider {

    static var `default`: Self {
        Self { app in
            app.profileWebAPIUseCases.use { app in
                ProfileApplicationFactory.makeFetchProfileUseCase(
                    basicProfileRepository: app.basicProfileRepository,
                    basicInfoRepository: app.basicInfoRepository,
                    profilePhotoRepository: app.profilePhotoRepository,
                    imageRepository: app.imageRepository,
                    profileInterestRepository: app.profileInterestRepository,
                    interestRepository: app.profileModuleInterestRepository
                )
            }

            app.profileWebAPIUseCases.use { app in
                ProfileApplicationFactory.makeCreateBasicProfileUseCase(
                    repository: app.basicProfileRepository,
                    userRepository: app.profileUserRepository
                )
            }

            app.profileWebAPIUseCases.use { app in
                ProfileApplicationFactory.makeFetchBasicProfileUseCase(
                    repository: app.basicProfileRepository
                )
            }

            app.profileWebAPIUseCases.use { app in
                ProfileApplicationFactory.makeCreateBasicInfoUseCase(
                    repository: app.basicInfoRepository,
                    userRepository: app.profileUserRepository,
                    countryRepository: app.profileCountryRepository,
                    genderRepository: app.profileGenderRepository
                )
            }

            app.profileWebAPIUseCases.use { app in
                ProfileApplicationFactory.makeFetchBasicInfoUseCase(
                    repository: app.basicInfoRepository
                )
            }

            app.profileWebAPIUseCases.use { app in
                ProfileApplicationFactory.makeAddProfilePhotoUseCase(
                    repository: app.profilePhotoRepository,
                    basicProfileRepository: app.basicProfileRepository,
                    imageRepository: app.imageRepository
                )
            }

            app.profileWebAPIUseCases.use { app in
                ProfileApplicationFactory.makeFetchProfilePhotosUseCase(
                    repository: app.profilePhotoRepository,
                    imageRepository: app.imageRepository
                )
            }

            app.profileWebAPIUseCases.use { app in
                ProfileApplicationFactory.makeFetchProfilePhotoUseCase(
                    repository: app.profilePhotoRepository,
                    imageRepository: app.imageRepository
                )
            }

            app.profileWebAPIUseCases.use { app in
                ProfileApplicationFactory.makeChangeProfilePhotoOrderUseCase(
                    repository: app.profilePhotoRepository,
                    basicProfileRepository: app.basicProfileRepository,
                    imageRepository: app.imageRepository
                )
            }

            app.profileWebAPIUseCases.use { app in
                ProfileApplicationFactory.makeDeleteProfilePhotoUseCase(
                    repository: app.profilePhotoRepository,
                    basicProfileRepository: app.basicProfileRepository,
                    imageRepository: app.imageRepository
                )
            }

            app.profileWebAPIUseCases.use { app in
                ProfileApplicationFactory.makeAddProfileInterestUseCase(
                    repository: app.profileInterestRepository,
                    interestRepository: app.profileModuleInterestRepository,
                    basicProfileRepository: app.basicProfileRepository
                )
            }

            app.profileWebAPIUseCases.use { app in
                ProfileApplicationFactory.makeFetchProfileInterestsUseCase(
                    repository: app.profileInterestRepository,
                    interestRepository: app.profileModuleInterestRepository,
                    basicProfileRepository: app.basicProfileRepository
                )
            }

            app.profileWebAPIUseCases.use { app in
                ProfileApplicationFactory.makeRemoveProfileInterestUseCase(
                    repository: app.profileInterestRepository,
                    basicProfileRepository: app.basicProfileRepository
                )
            }
        }
    }

}
