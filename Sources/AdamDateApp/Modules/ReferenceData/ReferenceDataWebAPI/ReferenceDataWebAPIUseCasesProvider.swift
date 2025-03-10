//
//  ReferenceDataUseCasesProvider.swift
//  AdamDateApp
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
        }
    }

}
