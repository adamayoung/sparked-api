//
//  CountryRemoteFluentDataSourceTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 06/02/2025.
//

import Fluent
import Foundation
import ReferenceDataApplication
import ReferenceDataDomain
import Testing
import XCTFluent

@testable import ReferenceDataInfrastructure

@Suite("CountryRemoteFluentDataSource")
struct CountryRemoteFluentDataSourceTests {

    let dataSource: CountryRemoteFluentDataSource
    let database: ArrayTestDatabase

    init() {
        self.database = ArrayTestDatabase()
        self.dataSource = CountryRemoteFluentDataSource(database: database.db)
    }

    @Test("fetchAll returns countries")
    func fetchAllReturnsCountries() async throws {
        let countryModels = try [
            CountryModel(
                id: #require(UUID(uuidString: "0D2ADFC7-7224-4154-9387-1C15EEB4D80F")),
                code: "GB",
                name: "United Kingdom",
                nameKey: "UNITED_KINGDOM"
            ),
            CountryModel(
                id: #require(UUID(uuidString: "1B4A387B-23FC-42ED-9B7C-F32CD96A3F96")),
                code: "US",
                name: "United States",
                nameKey: "UNITED_STATES"
            )
        ]
        let expectedCountries = try [
            Country(
                id: #require(UUID(uuidString: "0D2ADFC7-7224-4154-9387-1C15EEB4D80F")),
                code: "GB",
                name: "United Kingdom",
                nameKey: "UNITED_KINGDOM"
            ),
            Country(
                id: #require(UUID(uuidString: "1B4A387B-23FC-42ED-9B7C-F32CD96A3F96")),
                code: "US",
                name: "United States",
                nameKey: "UNITED_STATES"
            )
        ]
        database.append(countryModels)

        let countries = try await dataSource.fetchAll()

        #expect(countries == expectedCountries)
    }

}
