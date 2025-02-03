//
//  AuthenticateUserStubUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 29/01/2025.
//

import Foundation
import IdentityDomain

final class AuthenticateUserStubUseCase: AuthenticateUserUseCase, @unchecked Sendable {

    var executeResult: Result<User, AuthenticateUserError> = .failure(.unknown())
    private(set) var lastExecuteCredential: UserCredential?

    init() {}

    func execute(credential: UserCredential) async throws(AuthenticateUserError) -> User {
        lastExecuteCredential = credential

        return try executeResult.get()
    }

}
