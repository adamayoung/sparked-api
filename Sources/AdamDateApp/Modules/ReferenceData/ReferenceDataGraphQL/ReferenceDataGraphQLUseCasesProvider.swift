//
//  ReferenceDataGraphQLUseCasesProvider.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataGraphQL
import Vapor

extension Application.ReferenceDataGraphQLUseCases.Provider {

    static var `default`: Self {
        Self { app in
            app.referenceDataGraphQLUseCases.use { app in
                ReferenceDataApplicationFactory.makeFetchCountriesUseCase(
                    countryRepository: app.countryRepository
                )
            }

            app.referenceDataGraphQLUseCases.use { app in
                ReferenceDataApplicationFactory.makeFetchCountryUseCase(
                    countryRepository: app.countryRepository
                )
            }

            app.referenceDataGraphQLUseCases.use { app in
                ReferenceDataApplicationFactory.makeFetchGendersUseCase(
                    genderRepository: app.genderRepository
                )
            }

            app.referenceDataGraphQLUseCases.use { app in
                ReferenceDataApplicationFactory.makeFetchGenderUseCase(
                    genderRepository: app.genderRepository
                )
            }
        }
    }

}
