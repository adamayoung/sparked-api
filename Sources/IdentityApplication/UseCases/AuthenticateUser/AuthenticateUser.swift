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

    func execute(credential: UserCredential) async throws(AuthenticateUserError) -> UserDTO {
        let user: User

        do {
            user = try await repository.fetch(byEmail: credential.email)
        } catch UserRepositoryError.notFound {
            throw .invalidEmailOrPassword
        } catch let error {
            throw .unknown(error)
        }

        guard user.isActive else {
            throw .userDisabled
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

        let roles: [Role]
        do {
            roles = try await roleRepository.fetchAll(forUserID: user.id)
        } catch RoleRepositoryError.userNotFound {
            throw .invalidEmailOrPassword
        } catch let error {
            throw .unknown(error)
        }

        let userDTO = UserDTOMapper.map(from: user, roles: roles)

        return userDTO
    }

}
