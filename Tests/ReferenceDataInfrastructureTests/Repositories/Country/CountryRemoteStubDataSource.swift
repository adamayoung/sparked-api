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

    var fetchAllResult: Result<[Country], CountryRepositoryError> = .failure(.unknown())
    private(set) var fetchAllWasCalled = false

    var fetchByIDResult: Result<Country, CountryRepositoryError> = .failure(.unknown())
    private(set) var fetchByIDWasCalled = false
    private(set) var lastFetchByIDID: Country.ID?

    init() {}

    func fetchAll() async throws(CountryRepositoryError) -> [Country] {
        fetchAllWasCalled = true
        return try fetchAllResult.get()
    }

    func fetch(byID id: Country.ID) async throws(CountryRepositoryError) -> Country {
        fetchByIDWasCalled = true
        lastFetchByIDID = id
        return try fetchByIDResult.get()
    }

}
