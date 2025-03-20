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
    private(set) var executeWasCalled = false
    private(set) var lastExecuteParameters:
        (
            input: CreateBasicProfileInput,
            userContext: any UserContext
        )?

    init() {}

    func execute(
        input: CreateBasicProfileInput,
        userContext: some UserContext
    ) async throws(CreateBasicProfileError) -> BasicProfileDTO {
        executeWasCalled = true
        lastExecuteParameters = (input: input, userContext: userContext)

        return try executeResult.get()
    }

}
