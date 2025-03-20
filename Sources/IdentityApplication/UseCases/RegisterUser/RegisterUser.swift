//
//  RegisterUser.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation
import IdentityDomain

final class RegisterUser: RegisterUserUseCase {

    private static let defaultRoleCodes = ["USER"]

    private let repository: any UserRepository
    private let roleRepository: any RoleRepository
    private let hasher: any PasswordHasherService

    init(
        repository: some UserRepository,
        roleRepository: any RoleRepository,
        hasher: some PasswordHasherService
    ) {
        self.repository = repository
        self.roleRepository = roleRepository
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

        let roleCodes = input.roles.isEmpty ? Self.defaultRoleCodes : input.roles
        var roles: [Role] = []
        for roleCode in roleCodes {
            let role: Role
            do {
                role = try await roleRepository.fetch(byCode: roleCode)
            } catch RoleRepositoryError.notFound {
                throw .roleNotFound(roleCode: roleCode)
            } catch let error {
                throw .unknown(error)
            }

            roles.append(role)
        }

        do {
            try await repository.create(user, withRoles: roles)
        } catch UserRepositoryError.duplicateEmail {
            throw .emailAlreadyExists(email: input.email)
        } catch let error {
            throw .unknown(error)
        }

        let userDTO = UserDTOMapper.map(from: user, roles: roles)

        return userDTO
    }

}
