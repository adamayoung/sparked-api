//
//  RegisterUserStubRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 29/01/2025.
//

import Foundation
import IdentityApplication
import IdentityDomain

final class RegisterUserStubRepository: RegisterUserRepository {

    var createResult: Result<User, RegisterUserError> = .failure(.unknown())
    private(set) var createWasCalled = false
    private(set) var lastCreateUser: User?

    init() {}

    func create(user: User) async throws(RegisterUserError) -> User {
        createWasCalled = true
        lastCreateUser = user

        return try createResult.get()
    }

}
