//
//  FetchCountriesTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.

import Foundation
import ReferenceDataDomain
import Testing

@testable import ReferenceDataApplication

@Suite("FetchCountries")
@MainActor
struct FetchCountriesTests {

    let useCase: FetchCountries
    let repository: CountryStubRepository

    init() {
        self.repository = CountryStubRepository()
        self.useCase = FetchCountries(repository: repository)
    }

    @Test("execute returns sorted countries")
    func executeReturnsCountries() async throws {
        let countries = try [
            Country(
                id: #require(UUID(uuidString: "76A6BA42-A862-40C5-B917-38F41CE13486")),
                code: "US",
                name: "United States",
                nameKey: "UNITED_STATES"
            ),
            Country(
                id: #require(UUID(uuidString: "A964D9DD-5FCA-4B87-9383-4033A26D0900")),
                code: "GB",
                name: "United Kingdom",
                nameKey: "UNITED_KINGDOM"
            )
        ]

        let expectedCountryDTOs = try [
            CountryDTO(
                id: #require(UUID(uuidString: "A964D9DD-5FCA-4B87-9383-4033A26D0900")),
                code: "GB",
                name: "United Kingdom",
                nameKey: "UNITED_KINGDOM"
            ),
            CountryDTO(
                id: #require(UUID(uuidString: "76A6BA42-A862-40C5-B917-38F41CE13486")),
                code: "US",
                name: "United States",
                nameKey: "UNITED_STATES"
            )
        ]
        repository.fetchAllResult = .success(countries)

        let countryDTOs = try await useCase.execute()

        #expect(countryDTOs == expectedCountryDTOs)
        #expect(repository.fetchAllWasCalled)
    }

    @Test("execute when fails throws error")
    func executeWhenFailsThrowsError() async {
        repository.fetchAllResult = .failure(.unknown())

        await #expect(throws: FetchCountriesError.unknown(CountryRepositoryError.unknown())) {
            try await useCase.execute()
        }
        #expect(repository.fetchAllWasCalled)
    }

}
