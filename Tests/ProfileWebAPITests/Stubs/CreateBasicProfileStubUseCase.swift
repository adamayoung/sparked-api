//
//  CreateBasicProfileStubUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 30/01/2025.
//

import Foundation
import ProfileApplication

final class CreateBasicProfileStubUseCase: CreateBasicProfileUseCase, @unchecked Sendable {

    var executeResult: Result<BasicProfileDTO, CreateBasicProfileError> = .failure(.unknown())
    private(set) var lastExecuteInput: CreateBasicProfileInput?

    init() {}

    func execute(
        input: CreateBasicProfileInput
    ) async throws(CreateBasicProfileError) -> BasicProfileDTO {
        lastExecuteInput = input

        return try executeResult.get()
    }

}
