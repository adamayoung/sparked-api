//
//  Application+ReferenceDataInfrastructure.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import Fluent
import Foundation
import ReferenceDataApplication
import ReferenceDataInfrastructure
import ReferenceDataWebAPI
import Vapor

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

    var interestGroupRepository: any InterestGroupRepository {
        ReferenceDataInfrastructureFactory.makeInterestGroupRepository(
            database: self.db(DatabaseID.adamDate)
        )
    }

    var interestRepository: any InterestRepository {
        ReferenceDataInfrastructureFactory.makeInterestRepository(
            database: self.db(DatabaseID.adamDate)
        )
    }

}

extension Application {

    fileprivate var referenceDataCacheProvider: any CacheProvider {
        ReferenceDataCacheAdapter(
            cacheStore: self.cacheStore
        )
    }

}
