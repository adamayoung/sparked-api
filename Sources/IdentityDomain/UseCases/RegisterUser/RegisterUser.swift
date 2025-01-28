//
//  RegisterUser.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation
import IdentityEntities

package final class RegisterUser: RegisterUserUseCase {

    private let repository: any RegisterUserRepository

    package init(repository: some RegisterUserRepository) {
        self.repository = repository
    }

    @discardableResult
    package func execute(input: RegisterUserInput) async throws(RegisterUserError) -> User {
        let user = try await repository.create(input: input, isVerified: false)
        return user
    }

    @discardableResult
    package func execute(
        input: RegisterUserInput,
        isVerified: Bool
    ) async throws(RegisterUserError) -> User {
        let user = try await repository.create(input: input, isVerified: isVerified)
        return user
    }

}
