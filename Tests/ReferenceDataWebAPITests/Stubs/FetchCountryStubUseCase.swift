//
//  FetchCountryStubUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 13/02/2025.
//

import Foundation
import ReferenceDataApplication

final class FetchCountryStubUseCase: FetchCountryUseCase, @unchecked Sendable {

    var executeResult: Result<CountryDTO, FetchCountryError> = .failure(.unknown())
    private(set) var executeCalled = false
    private(set) var lastExecuteID: CountryDTO.ID?

    init() {}

    func execute(id: CountryDTO.ID) async throws(FetchCountryError) -> CountryDTO {
        executeCalled = true
        lastExecuteID = id

        return try executeResult.get()
    }

}
