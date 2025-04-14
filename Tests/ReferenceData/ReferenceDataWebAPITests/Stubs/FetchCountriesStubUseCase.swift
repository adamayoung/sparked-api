//
//  FetchCountriesStubUseCase.swift
//  SparkedAPI
//
//  Created by Adam Young on 06/02/2025.
//

import Foundation
import ReferenceDataApplication

final class FetchCountriesStubUseCase: FetchCountriesUseCase, @unchecked Sendable {

    var executeResult: Result<[CountryDTO], FetchCountriesError> = .failure(.unknown())
    private(set) var executeCalled = false

    init() {}

    func execute() async throws(FetchCountriesError) -> [CountryDTO] {
        executeCalled = true

        return try executeResult.get()
    }

}
