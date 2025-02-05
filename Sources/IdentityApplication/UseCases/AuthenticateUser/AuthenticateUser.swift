//
//  AuthenticateUser.swift
//  AdamDateApp
//
//  Created by Adam Young on 24/01/2025.
//

import Foundation
import IdentityDomain

package final class AuthenticateUser: AuthenticateUserUseCase {

    private let repository: any AuthenticateUserRepository

    package init(repository: some AuthenticateUserRepository) {
        self.repository = repository
    }

    package func execute(credential: UserCredential) async throws(AuthenticateUserError) -> UserDTO
    {
        let user = try await repository.authenticate(
            email: credential.email,
            password: credential.password
        )
        let userDTO = UserDTOMapper.map(from: user)

        return userDTO
    }

}
