//
//  RegisterUser.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation
import IdentityDomain

package final class RegisterUser: RegisterUserUseCase {

    private let repository: any RegisterUserRepository
    private let hasher: any PasswordHasherService

    package init(
        repository: some RegisterUserRepository,
        hasher: some PasswordHasherService
    ) {
        self.repository = repository
        self.hasher = hasher
    }

    @discardableResult
    package func execute(input: RegisterUserInput) async throws(RegisterUserError) -> UserDTO {
        let passwordValidator = PasswordValidator()
        do {
            try passwordValidator.validate(input.password)
        } catch let error {
            throw RegisterUserError(error: error)
        }

        let user: User
        do {
            user = try UserMapper.map(from: input, using: hasher)
        } catch let error {
            throw .unknown(error)
        }

        let userValidator = UserValidator()
        do {
            try userValidator.validate(user)
        } catch let error {
            throw RegisterUserError(error: error)
        }

        try await repository.create(user)
        let userDTO = UserDTOMapper.map(from: user)

        return userDTO
    }

}
