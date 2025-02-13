//
//  RegisterUser.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation
import IdentityDomain

final class RegisterUser: RegisterUserUseCase {

    private let repository: any UserRepository
    private let hasher: any PasswordHasherService

    init(
        repository: some UserRepository,
        hasher: some PasswordHasherService
    ) {
        self.repository = repository
        self.hasher = hasher
    }

    @discardableResult
    func execute(input: RegisterUserInput) async throws(RegisterUserError) -> UserDTO {
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

        do {
            try await repository.create(user)
        } catch UserRepositoryError.duplicateEmail {
            throw .emailAlreadyExists(email: input.email)
        } catch let error {
            throw .unknown(error)
        }

        let userDTO = UserDTOMapper.map(from: user)

        return userDTO
    }

}
