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
    private let hasher: any PasswordHasherService

    package init(
        repository: some AuthenticateUserRepository,
        hasher: some PasswordHasherService
    ) {
        self.repository = repository
        self.hasher = hasher
    }

    package func execute(
        credential: UserCredential
    ) async throws(AuthenticateUserError) -> UserDTO {
        let user = try await repository.fetchForAuthentication(byEmail: credential.email)

        let isPasswordMatch: Bool
        do {
            isPasswordMatch = try hasher.verify(credential.password, created: user.passwordHash)
        } catch {
            throw .invalidEmailOrPassword
        }

        guard isPasswordMatch else {
            throw .invalidEmailOrPassword
        }

        let userDTO = UserDTOMapper.map(from: user)

        return userDTO
    }

}
