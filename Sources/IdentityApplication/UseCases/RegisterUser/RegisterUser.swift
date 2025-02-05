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

    package init(repository: some RegisterUserRepository) {
        self.repository = repository
    }

    @discardableResult
    package func execute(input: RegisterUserInput) async throws(RegisterUserError) -> UserDTO {
        let user = try await repository.create(input: input)
        let userDTO = UserDTOMapper.map(from: user)

        return userDTO
    }

}
