//
//  ProfileGraphQLUseCasesProvider.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import Foundation
import IdentityApplication
import ProfileApplication
import ProfileWebAPI
import ReferenceDataApplication
import Vapor

extension Application.ProfileGraphQLUseCases.Provider {

    static var `default`: Self {
        Self { app in
            app.profileGraphQLUseCases.use { app in
                ProfileApplicationFactory.makeFetchProfileUseCase(
                    basicProfileRepository: app.basicProfileRepository,
                    basicInfoRepository: app.basicInfoRepository
                )
            }

            app.profileGraphQLUseCases.use { app in
                ProfileApplicationFactory.makeCreateBasicProfileUseCase(
                    repository: app.basicProfileRepository,
                    userService: app.profileUserService
                )
            }

            app.profileGraphQLUseCases.use { app in
                ProfileApplicationFactory.makeFetchBasicProfileUseCase(
                    repository: app.basicProfileRepository
                )
            }

            app.profileGraphQLUseCases.use { app in
                ProfileApplicationFactory.makeCreateBasicInfoUseCase(
                    repository: app.basicInfoRepository,
                    userService: app.profileUserService,
                    countryService: app.profileCountryService,
                    genderService: app.profileGenderService
                )
            }

            app.profileGraphQLUseCases.use { app in
                ProfileApplicationFactory.makeFetchBasicInfoUseCase(
                    repository: app.basicInfoRepository
                )
            }

            app.profileGraphQLUseCases.use { app in
                ProfileApplicationFactory.makeAddProfilePhotoUseCase(
                    repository: app.profilePhotoRepository,
                    basicProfileRepository: app.basicProfileRepository,
                    imageRepository: app.imageRepository
                )
            }

            app.profileGraphQLUseCases.use { app in
                ProfileApplicationFactory.makeFetchProfilePhotosUseCase(
                    repository: app.profilePhotoRepository,
                    imageRepository: app.imageRepository
                )
            }

            app.profileGraphQLUseCases.use { app in
                ProfileApplicationFactory.makeFetchProfilePhotoUseCase(
                    repository: app.profilePhotoRepository,
                    imageRepository: app.imageRepository
                )
            }
        }
    }

}
