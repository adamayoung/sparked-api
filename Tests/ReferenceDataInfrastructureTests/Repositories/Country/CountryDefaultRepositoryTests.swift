//
//  CountryDefaultRepositoryTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 06/02/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain
import Testing

@testable import ReferenceDataInfrastructure

@Suite("CountryDefaultRepository")
struct CountryDefaultRepositoryTests {

    let repository: CountryDefaultRepository
    let remoteDataSource: CountryRemoteStubDataSource

    init() {
        self.remoteDataSource = CountryRemoteStubDataSource()
        self.repository = CountryDefaultRepository(
            remoteDataSource: self.remoteDataSource
        )
    }

    @Test("countries returns countries")
    func countriesReturnsCountries() async throws {
        let expectedCountries = try [
            Country(
                id: #require(UUID(uuidString: "76A6BA42-A862-40C5-B917-38F41CE13486")),
                code: "US",
                name: "United States"
            ),
            Country(
                id: #require(UUID(uuidString: "A964D9DD-5FCA-4B87-9383-4033A26D0900")),
                code: "GB",
                name: "United Kingdom"
            )
        ]
        remoteDataSource.fetchAllResult = .success(expectedCountries)

        let countries = try await repository.fetchAll()

        #expect(countries == expectedCountries)
        #expect(remoteDataSource.fetchAllWasCalled)
    }

    @Test("countries when fails throws error")
    func countriesWhenFailsThrowsError() async throws {
        remoteDataSource.fetchAllResult = .failure(.unknown())

        await #expect(throws: FetchCountriesError.unknown()) {
            try await repository.fetchAll()
        }
        #expect(remoteDataSource.fetchAllWasCalled)
    }

}
