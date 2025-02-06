//
//  AuthenticateUserStubRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 29/01/2025.
//

import Foundation
import IdentityApplication
import IdentityDomain

final class AuthenticateUserStubRepository: AuthenticateUserRepository {

    var fetchForAuthenticationResult: Result<User, AuthenticateUserError> = .failure(.unknown(nil))
    private(set) var lastAuthenticateEmail: String?

    init() {}

    func fetchForAuthentication(byEmail email: String) async throws(AuthenticateUserError) -> User {
        lastAuthenticateEmail = email

        return try fetchForAuthenticationResult.get()
    }

}
