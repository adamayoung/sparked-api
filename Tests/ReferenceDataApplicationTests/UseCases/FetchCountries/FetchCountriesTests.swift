//
//  FetchCountriesTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.

import Foundation
import ReferenceDataDomain
import Testing

@testable import ReferenceDataApplication

@Suite
struct FetchCountriesTests {

    let useCase: FetchCountries
    let repository: FetchCountriesStubRepository

    init() {
        self.repository = FetchCountriesStubRepository()
        self.useCase = FetchCountries(repository: repository)
    }

    @Test("execute returns sorted countries")
    func executeReturnsCountries() async throws {
        let countries = try [
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

        let expectedCountryDTOs = try [
            CountryDTO(
                id: #require(UUID(uuidString: "A964D9DD-5FCA-4B87-9383-4033A26D0900")),
                code: "GB",
                name: "United Kingdom"
            ),
            CountryDTO(
                id: #require(UUID(uuidString: "76A6BA42-A862-40C5-B917-38F41CE13486")),
                code: "US",
                name: "United States"
            )
        ]
        repository.countriesResult = .success(countries)

        let countryDTOs = try await useCase.execute()

        #expect(countryDTOs == expectedCountryDTOs)
        #expect(repository.countriesWasCalled)
    }

    @Test("execute when fails throws error")
    func executeWhenFailsThrowsError() async {
        repository.countriesResult = .failure(.unknown())

        await #expect(throws: FetchCountriesError.unknown()) {
            try await useCase.execute()
        }
    }

}
