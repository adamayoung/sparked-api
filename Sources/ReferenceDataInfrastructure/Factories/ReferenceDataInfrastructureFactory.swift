//
//  ReferenceDataInfrastructureFactory.swift
//  SparkedAPI
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

    package static func makeInterestGroupRepository(
        database: some Database,
        cacheProvider: some CacheProvider
    ) -> some InterestGroupRepository {
        let remoteDataSource = Self.makeInterestGroupRemoteDataSource(database: database)
        let cacheDataSource = Self.makeInterestGroupCacheDataSource(cacheProvider: cacheProvider)

        return InterestGroupDefaultRepository(
            remoteDataSource: remoteDataSource,
            cacheDataSource: cacheDataSource
        )
    }

    package static func makeInterestRepository(
        database: some Database,
        cacheProvider: some CacheProvider
    ) -> some InterestRepository {
        let remoteDataSource = Self.makeInterestRemoteDataSource(database: database)
        let cacheDataSource = Self.makeInterestCacheDataSource(cacheProvider: cacheProvider)

        return InterestDefaultRepository(
            remoteDataSource: remoteDataSource,
            cacheDataSource: cacheDataSource
        )
    }

    package static func makeStarSignRepository(
        database: some Database,
        cacheProvider: some CacheProvider
    ) -> some StarSignRepository {
        let remoteDataSource = Self.makeStarSignRemoteDataSource(database: database)
        let cacheDataSource = Self.makeStarSignCacheDataSource(cacheProvider: cacheProvider)

        return StarSignDefaultRepository(
            remoteDataSource: remoteDataSource,
            cacheDataSource: cacheDataSource
        )
    }

    package static func makeEducationLevelRepository(
        database: some Database,
        cacheProvider: some CacheProvider
    ) -> some EducationLevelRepository {
        let remoteDataSource = Self.makeEducationLevelRemoteDataSource(database: database)
        let cacheDataSource = Self.makeEducationLevelCacheDataSource(cacheProvider: cacheProvider)

        return EducationLevelDefaultRepository(
            remoteDataSource: remoteDataSource,
            cacheDataSource: cacheDataSource
        )
    }

}

extension ReferenceDataInfrastructureFactory {

    package static func makeMigrations() -> [any Migration] {
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

    private static func makeInterestGroupRemoteDataSource(
        database: some Database
    ) -> some InterestGroupRemoteDataSource {
        InterestGroupRemoteFluentDataSource(database: database)
    }

    private static func makeInterestRemoteDataSource(
        database: some Database
    ) -> some InterestRemoteDataSource {
        InterestRemoteFluentDataSource(database: database)
    }

    private static func makeStarSignRemoteDataSource(
        database: some Database
    ) -> some StarSignRemoteDataSource {
        StarSignRemoteFluentDataSource(database: database)
    }

    private static func makeEducationLevelRemoteDataSource(
        database: some Database
    ) -> some EducationLevelRemoteDataSource {
        EducationLevelRemoteFluentDataSource(database: database)
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

    private static func makeEducationLevelCacheDataSource(
        cacheProvider: some CacheProvider
    ) -> some EducationLevelCacheDataSource {
        EducationLevelCacheDefaultDataSource(cacheProvider: cacheProvider)
    }

    private static func makeStarSignCacheDataSource(
        cacheProvider: some CacheProvider
    ) -> some StarSignCacheDataSource {
        StarSignCacheDefaultDataSource(cacheProvider: cacheProvider)
    }

    private static func makeInterestGroupCacheDataSource(
        cacheProvider: some CacheProvider
    ) -> some InterestGroupCacheDataSource {
        InterestGroupCacheDefaultDataSource(cacheProvider: cacheProvider)
    }

    private static func makeInterestCacheDataSource(
        cacheProvider: some CacheProvider
    ) -> some InterestCacheDataSource {
        InterestCacheDefaultDataSource(cacheProvider: cacheProvider)
    }

}
