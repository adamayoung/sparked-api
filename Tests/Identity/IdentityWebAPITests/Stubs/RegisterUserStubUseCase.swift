//
//  RegisterUserStubUseCase.swift
//  SparkedAPI
//
//  Created by Adam Young on 29/01/2025.
//

import Foundation
import IdentityApplication

final class RegisterUserStubUseCase: RegisterUserUseCase, @unchecked Sendable {

    var executeResult: Result<UserDTO, RegisterUserError> = .failure(.unknown())
    private(set) var lastExecuteInput: RegisterUserInput?

    init() {}

    @discardableResult
    func execute(input: RegisterUserInput) async throws(RegisterUserError) -> UserDTO {
        lastExecuteInput = input

        return try executeResult.get()
    }

}
