//
//  FetchCountriesTests.swift
//  SparkedAPI
//
//  Created by Adam Young on 04/02/2025.

import Foundation
import ReferenceDataDomain
import Testing

@testable import ReferenceDataApplication

@Suite("FetchCountries")
struct FetchCountriesTests {

    let useCase: FetchCountries
    let repository: CountryStubRepository

    init() {
        self.repository = CountryStubRepository()
        self.useCase = FetchCountries(repository: repository)
    }

    @Test("execute returns sorted countries")
    func executeReturnsCountries() async throws {
        let countries: [Country] = try [.unitedStatesMock(), .unitedKingdomMock()]
        let expectedCountryDTOs: [CountryDTO] = try [.unitedKingdomMock(), .unitedStatesMock()]

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
