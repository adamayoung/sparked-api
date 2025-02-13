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
        hasher: some PasswordHasherService
    ) -> some AuthenticateUserUseCase {
        AuthenticateUser(repository: repository, hasher: hasher)
    }

    package static func makeFetchUserUseCase(
        repository: some UserRepository
    ) -> some FetchUserUseCase {
        FetchUser(repository: repository)
    }

    package static func makeRegisterUserUseCase(
        repository: some UserRepository,
        hasher: some PasswordHasherService
    ) -> some RegisterUserUseCase {
        RegisterUser(repository: repository, hasher: hasher)
    }

}
