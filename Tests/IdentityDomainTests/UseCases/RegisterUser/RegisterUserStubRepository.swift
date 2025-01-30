//
//  RegisterUserStubRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 29/01/2025.
//

import Foundation
import IdentityDomain
import IdentityEntities

final class RegisterUserStubRepository: RegisterUserRepository {

    var createResult: Result<User, RegisterUserError> = .failure(.unknown())
    var lastCreateInput: RegisterUserInput?

    init() {}

    func create(input: RegisterUserInput) async throws(RegisterUserError) -> User {
        lastCreateInput = input

        return try createResult.get()
    }

}
