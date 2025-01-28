//
//  AuthenticateUser.swift
//  AdamDateApp
//
//  Created by Adam Young on 24/01/2025.
//

import Foundation
import IdentityEntities

package final class AuthenticateUser: AuthenticateUserUseCase {

    private let repository: any AuthenticateUserRepository

    package init(repository: some AuthenticateUserRepository) {
        self.repository = repository
    }

    package func execute(credential: UserCredential) async throws(AuthenticateUserError) -> User {
        let user = try await repository.authenticate(
            email: credential.email,
            password: credential.password
        )

        return user
    }

}
