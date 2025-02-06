//
//  FetchGendersStubUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 06/02/2025.
//

import Foundation
import ReferenceDataApplication

final class FetchGendersStubUseCase: FetchGendersUseCase, @unchecked Sendable {

    var executeResult: Result<[GenderDTO], FetchGendersError> = .failure(.unknown())
    private(set) var executeCalled = false

    init() {}

    func execute() async throws(FetchGendersError) -> [GenderDTO] {
        executeCalled = true

        return try executeResult.get()
    }

}
