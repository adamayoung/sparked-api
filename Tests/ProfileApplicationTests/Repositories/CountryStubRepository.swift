//
//  CountryStubRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation
import ProfileApplication
import ProfileDomain

final class CountryStubRepository: CountryRepository {

    var fetchByIDResult: Result<Country, CountryRepositoryError> = .failure(.unknown())
    private(set) var fetchByIDWasCalled = false
    private(set) var lastFetchByIDID: Country.ID?

    init() {}

    func fetch(byID id: Country.ID) async throws(CountryRepositoryError) -> Country {
        fetchByIDWasCalled = true
        lastFetchByIDID = id

        return try fetchByIDResult.get()
    }

}
