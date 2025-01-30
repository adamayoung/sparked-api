//
//  AuthenticateUserStubRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 29/01/2025.
//

import Foundation
import IdentityDomain
import IdentityEntities

final class AuthenticateUserStubRepository: AuthenticateUserRepository {

    var authenticateResult: Result<User, AuthenticateUserError> = .failure(.unknown(nil))
    private(set) var lastAuthenticateEmail: String?
    private(set) var lastAuthenticatePassword: String?

    init() {}

    func authenticate(email: String, password: String) async throws(AuthenticateUserError) -> User {
        lastAuthenticateEmail = email
        lastAuthenticatePassword = password

        return try authenticateResult.get()
    }

}
