//
//  CreateBasicProfileStubUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 30/01/2025.
//

import Foundation
import ProfileDomain

final class CreateBasicProfileStubUseCase: CreateBasicProfileUseCase, @unchecked Sendable {

    var executeResult: Result<BasicProfile, CreateBasicProfileError> = .failure(.unknown())
    private(set) var lastExecuteInput: CreateBasicProfileInput?

    init() {}

    func execute(
        input: CreateBasicProfileInput
    ) async throws(CreateBasicProfileError) -> BasicProfile {
        lastExecuteInput = input

        return try executeResult.get()
    }

}
