//
//  CountryStaticRepositoryTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation
import ReferenceDataDomain
import Testing

@testable import ReferenceDataInfrastructure

@Suite
struct CountryStaticRepositoryTests {

    let repository: CountryStaticRepository

    init() {
        self.repository = CountryStaticRepository()
    }

    @Test(
        "countries contains country",
        arguments: [
            Country(id: "GB", name: "United Kingdom"),
            Country(id: "US", name: "United States"),
            Country(id: "ES", name: "Spain")
        ]
    )
    func countriesContainsCountry(expectedCountry: Country) async throws {
        let countries = try await repository.countries()

        #expect(countries[expectedCountry.id] == expectedCountry)
    }

}
