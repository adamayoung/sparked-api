//
//  AuthenticateUser.swift
//  AdamDateApp
//
//  Created by Adam Young on 24/01/2025.
//

import Foundation
import IdentityDomain

final class AuthenticateUser: AuthenticateUserUseCase {

    private let repository: any UserRepository
    private let hasher: any PasswordHasherService

    init(
        repository: some UserRepository,
        hasher: some PasswordHasherService
    ) {
        self.repository = repository
        self.hasher = hasher
    }

    func execute(credential: UserCredential) async throws(AuthenticateUserError) -> UserDTO {
        let user: User

        do {
            user = try await repository.fetch(byEmail: credential.email)
        } catch UserRepositoryError.notFound {
            throw .invalidEmailOrPassword
        } catch let error {
            throw .unknown(error)
        }

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
