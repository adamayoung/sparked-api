//
//  ReferenceDataUseCasesProvider.swift
//  SparkedAPI
//
//  Created by Adam Young on 13/02/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataWebAPI
import Vapor

extension Application.ReferenceDataWebAPIUseCases.Provider {

    static var `default`: Self {
        Self { app in
            app.referenceDataWebAPIUseCases.use { app in
                ReferenceDataApplicationFactory.makeFetchCountriesUseCase(
                    countryRepository: app.countryRepository
                )
            }

            app.referenceDataWebAPIUseCases.use { app in
                ReferenceDataApplicationFactory.makeFetchCountryUseCase(
                    countryRepository: app.countryRepository
                )
            }

            app.referenceDataWebAPIUseCases.use { app in
                ReferenceDataApplicationFactory.makeFetchGendersUseCase(
                    genderRepository: app.genderRepository
                )
            }

            app.referenceDataWebAPIUseCases.use { app in
                ReferenceDataApplicationFactory.makeFetchGenderUseCase(
                    genderRepository: app.genderRepository
                )
            }

            app.referenceDataWebAPIUseCases.use { app in
                ReferenceDataApplicationFactory.makeFetchInterestGroupsUseCase(
                    interestGroupRepository: app.interestGroupRepository,
                    interestRepository: app.interestRepository
                )
            }

            app.referenceDataWebAPIUseCases.use { app in
                ReferenceDataApplicationFactory.makeFetchInterestGroupUseCase(
                    interestGroupRepository: app.interestGroupRepository,
                    interestRepository: app.interestRepository
                )
            }

            app.referenceDataWebAPIUseCases.use { app in
                ReferenceDataApplicationFactory.makeFetchInterestsUseCase(
                    interestRepository: app.interestRepository
                )
            }

            app.referenceDataWebAPIUseCases.use { app in
                ReferenceDataApplicationFactory.makeFetchInterestUseCase(
                    interestRepository: app.interestRepository
                )
            }

            app.referenceDataWebAPIUseCases.use { app in
                ReferenceDataApplicationFactory.makeFetchStarSignsUseCase(
                    starSignRepository: app.starSignRepository
                )
            }

            app.referenceDataWebAPIUseCases.use { app in
                ReferenceDataApplicationFactory.makeFetchStarSignUseCase(
                    starSignRepository: app.starSignRepository
                )
            }

            app.referenceDataWebAPIUseCases.use { app in
                ReferenceDataApplicationFactory.makeFetchEducationLevelsUseCase(
                    educationLevelRepository: app.educationLevelRepository
                )
            }

            app.referenceDataWebAPIUseCases.use { app in
                ReferenceDataApplicationFactory.makeFetchEducationLevelUseCase(
                    educationLevelRepository: app.educationLevelRepository
                )
            }
        }
    }

}
