//
//  CountryStubService.swift
//  AdamDateApp
//
//  Created by Adam Young on 13/02/2025.
//

import Foundation
import ProfileApplication

final class CountryStubService: CountryService {

    var doesCountryExistResult: Result<Bool, CountryServiceError> = .success(true)
    private(set) var doesCountryExistWasCalled = false
    private(set) var lastDoesCountryExistWithIDID: UUID?

    func doesCountryExist(withID id: UUID) async throws(CountryServiceError) -> Bool {
        doesCountryExistWasCalled = true
        lastDoesCountryExistWithIDID = id
        return try doesCountryExistResult.get()
    }

}
