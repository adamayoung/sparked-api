//
//  FetchCountriesStubRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation
import ReferenceDataDomain

final class FetchCountriesStubRepository: FetchCountriesRepository {

    var countriesResult: Result<[Country.ID: Country], FetchCountriesError> = .failure(.unknown())
    private(set) var countriesWasCalled = false

    init() {}

    func countries() async throws(FetchCountriesError) -> [Country.ID: Country] {
        countriesWasCalled = true
        return try countriesResult.get()
    }

}
