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
        let countryModels: [CountryModel] = [.unitedKingdomMock(), .unitedStatesMock()]
        let expectedCountries: [Country] = try [.unitedKingdomMock(), .unitedStatesMock()]
        database.append(countryModels)

        let countries = try await dataSource.fetchAll()

        #expect(countries == expectedCountries)
    }

}
