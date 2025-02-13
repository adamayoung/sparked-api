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
        database: some Database
    ) -> some CountryRepository {
        let remoteDataSource = Self.makeCountryRemoteDataSource(database: database)

        return CountryDefaultRepository(
            remoteDataSource: remoteDataSource
        )
    }

    package static func makeGenderRepository(
        database: some Database
    ) -> some GenderRepository {
        let remoteDataSource = Self.makeGenderRemoteDataSource(database: database)

        return GenderDefaultRepository(
            remoteDataSource: remoteDataSource
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
