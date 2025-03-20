//
//  Application+ReferenceDataInfrastructure.swift
//  SparkedAPI
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
            database: self.db(DatabaseID.sparked),
            cacheProvider: self.referenceDataCacheProvider
        )
    }

    var genderRepository: any GenderRepository {
        ReferenceDataInfrastructureFactory.makeGenderRepository(
            database: self.db(DatabaseID.sparked),
            cacheProvider: self.referenceDataCacheProvider
        )
    }

    var interestGroupRepository: any InterestGroupRepository {
        ReferenceDataInfrastructureFactory.makeInterestGroupRepository(
            database: self.db(DatabaseID.sparked),
            cacheProvider: self.referenceDataCacheProvider
        )
    }

    var interestRepository: any InterestRepository {
        ReferenceDataInfrastructureFactory.makeInterestRepository(
            database: self.db(DatabaseID.sparked),
            cacheProvider: self.referenceDataCacheProvider
        )
    }

    var starSignRepository: any StarSignRepository {
        ReferenceDataInfrastructureFactory.makeStarSignRepository(
            database: self.db(DatabaseID.sparked),
            cacheProvider: self.referenceDataCacheProvider
        )
    }

    var educationLevelRepository: any EducationLevelRepository {
        ReferenceDataInfrastructureFactory.makeEducationLevelRepository(
            database: self.db(DatabaseID.sparked),
            cacheProvider: self.referenceDataCacheProvider
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
