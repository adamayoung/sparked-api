//
//  IdentityApplicationFactory.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/02/2025.
//

import Foundation

package final class IdentityApplicationFactory: Sendable {

    private init() {}

    package static func makeAuthenticateUserUseCase(
        repository: some UserRepository,
        roleRepository: some RoleRepository,
        hasher: some PasswordHasherService
    ) -> some AuthenticateUserUseCase {
        AuthenticateUser(
            repository: repository,
            roleRepository: roleRepository,
            hasher: hasher
        )
    }

    package static func makeFetchUserUseCase(
        repository: some UserRepository,
        roleRepository: some RoleRepository
    ) -> some FetchUserUseCase {
        FetchUser(
            repository: repository,
            roleRepository: roleRepository
        )
    }

    package static func makeRegisterUserUseCase(
        repository: some UserRepository,
        roleRepository: some RoleRepository,
        hasher: some PasswordHasherService
    ) -> some RegisterUserUseCase {
        RegisterUser(
            repository: repository,
            roleRepository: roleRepository,
            hasher: hasher
        )
    }

    package static func makeFetchRoleUseCase(
        repository: some RoleRepository
    ) -> some FetchRolesUseCase {
        FetchRoles(repository: repository)
    }

}
