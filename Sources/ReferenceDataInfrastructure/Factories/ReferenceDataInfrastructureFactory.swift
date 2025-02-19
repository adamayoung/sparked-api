//
//  ReferenceDataInfrastructureFactory.swift
//  AdamDateApp
//
//  Created by Adam Young on 13/02/2025.
//

import Fluent
import Foundation
import ReferenceDataApplication

package final class ReferenceDataInfrastructureFactory: Sendable {

    private init() {}

    package static func makeCountryRepository(
        database: some Database,
        cacheProvider: some CacheProvider
    ) -> some CountryRepository {
        let remoteDataSource = Self.makeCountryRemoteDataSource(database: database)
        let cacheDataSource = Self.makeCountryCacheDataSource(cacheProvider: cacheProvider)

        return CountryDefaultRepository(
            remoteDataSource: remoteDataSource,
            cacheDataSource: cacheDataSource
        )
    }

    package static func makeGenderRepository(
        database: some Database,
        cacheProvider: some CacheProvider
    ) -> some GenderRepository {
        let remoteDataSource = Self.makeGenderRemoteDataSource(database: database)
        let cacheDataSource = Self.makeGenderCacheDataSource(cacheProvider: cacheProvider)

        return GenderDefaultRepository(
            remoteDataSource: remoteDataSource,
            cacheDataSource: cacheDataSource
        )
    }

    package static func makeMigrations() -> [Migration] {
        ReferenceDataMigrations.all()
    }

}

extension ReferenceDataInfrastructureFactory {

    private static func makeCountryRemoteDataSource(
        database: some Database
    ) -> some CountryRemoteDataSource {
        CountryRemoteFluentDataSource(database: database)
    }

    private static func makeGenderRemoteDataSource(
        database: some Database
    ) -> some GenderRemoteDataSource {
        GenderRemoteFluentDataSource(database: database)
    }

}

extension ReferenceDataInfrastructureFactory {

    private static func makeCountryCacheDataSource(
        cacheProvider: some CacheProvider
    ) -> some CountryCacheDataSource {
        CountryCacheDefaultDataSource(cacheProvider: cacheProvider)
    }

    private static func makeGenderCacheDataSource(
        cacheProvider: some CacheProvider
    ) -> some GenderCacheDataSource {
        GenderCacheDefaultDataSource(cacheProvider: cacheProvider)
    }

}
