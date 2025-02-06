//
//  CountryRemoteStubDataSource.swift
//  AdamDateApp
//
//  Created by Adam Young on 06/02/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain
import ReferenceDataInfrastructure

final class CountryRemoteStubDataSource: CountryRemoteDataSource {

    var countriesResult: Result<[Country], FetchCountriesError> = .failure(.unknown())
    private(set) var countriesWasCalled = false

    init() {}

    func countries() async throws(FetchCountriesError) -> [Country] {
        countriesWasCalled = true

        return try countriesResult.get()
    }

}
