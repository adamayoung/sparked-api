//
//  ReferenceDataUseCasesProvider.swift
//  AdamDateApp
//
//  Created by Adam Young on 13/02/2025.
//

import Fluent
import Foundation
import ReferenceDataApplication
import ReferenceDataInfrastructure
import ReferenceDataPresentation
import Vapor

extension Application.ReferenceDataUseCases.Provider {

    static var `default`: Self {
        Self { app in
            app.referenceDataUseCases.use { app in
                ReferenceDataApplicationFactory.makeFetchCountriesUseCase(
                    countryRepository: app.countryRepository
                )
            }

            app.referenceDataUseCases.use { app in
                ReferenceDataApplicationFactory.makeFetchCountryUseCase(
                    countryRepository: app.countryRepository
                )
            }

            app.referenceDataUseCases.use { app in
                ReferenceDataApplicationFactory.makeFetchGendersUseCase(
                    genderRepository: app.genderRepository
                )
            }

            app.referenceDataUseCases.use { app in
                ReferenceDataApplicationFactory.makeFetchGenderUseCase(
                    genderRepository: app.genderRepository
                )
            }
        }
    }

}

extension Application {

    var countryRepository: any CountryRepository {
        ReferenceDataInfrastructureFactory.makeCountryRepository(
            database: self.db(DatabaseID.adamDate),
            cacheProvider: self.referenceDataCacheProvider
        )
    }

    var genderRepository: any GenderRepository {
        ReferenceDataInfrastructureFactory.makeGenderRepository(
            database: self.db(DatabaseID.adamDate),
            cacheProvider: self.referenceDataCacheProvider
        )
    }

    var referenceDataCacheProvider: any CacheProvider {
        ReferenceDataCacheAdapter(
            cacheStore: CoreInfrastructureFactory.makeCacheStore()
        )
    }

}
