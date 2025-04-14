//
//  FetchGenderStubUseCase.swift
//  SparkedAPI
//
//  Created by Adam Young on 13/02/2025.
//

import Foundation
import ReferenceDataApplication

final class FetchGenderStubUseCase: FetchGenderUseCase, @unchecked Sendable {

    var executeResult: Result<GenderDTO, FetchGenderError> = .failure(.unknown())
    private(set) var executeCalled = false
    private(set) var lastExecuteID: GenderDTO.ID?

    init() {}

    func execute(id: GenderDTO.ID) async throws(FetchGenderError) -> GenderDTO {
        executeCalled = true
        lastExecuteID = id

        return try executeResult.get()
    }

}
