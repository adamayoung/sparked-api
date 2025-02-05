//
//  AuthenticateUserStubUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 29/01/2025.
//

import Foundation
import IdentityApplication

final class AuthenticateUserStubUseCase: AuthenticateUserUseCase, @unchecked Sendable {

    var executeResult: Result<UserDTO, AuthenticateUserError> = .failure(.unknown())
    private(set) var lastExecuteCredential: UserCredential?

    init() {}

    func execute(credential: UserCredential) async throws(AuthenticateUserError) -> UserDTO {
        lastExecuteCredential = credential

        return try executeResult.get()
    }

}
