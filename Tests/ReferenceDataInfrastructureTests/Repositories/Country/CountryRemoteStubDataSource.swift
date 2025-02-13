//
//  CountryRemoteStubDataSource.swift
//  AdamDateApp
//
//  Created by Adam Young on 06/02/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

@testable import ReferenceDataInfrastructure

final class CountryRemoteStubDataSource: CountryRemoteDataSource {

    var fetchAllResult: Result<[Country], FetchCountriesError> = .failure(.unknown())
    private(set) var fetchAllWasCalled = false

    var fetchByIDResult: Result<Country, FetchCountryError> = .failure(.unknown())
    private(set) var fetchByIDWasCalled = false
    private(set) var lastFetchByIDID: Country.ID?

    init() {}

    func fetchAll() async throws(FetchCountriesError) -> [Country] {
        fetchAllWasCalled = true
        return try fetchAllResult.get()
    }

    func fetch(byID id: Country.ID) async throws(FetchCountryError) -> Country {
        fetchByIDWasCalled = true
        lastFetchByIDID = id
        return try fetchByIDResult.get()
    }

}
