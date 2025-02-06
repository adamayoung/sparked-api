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

    var createResult: Result<Void, RegisterUserError> = .failure(.unknown())
    private(set) var createWasCalled = false
    private(set) var lastCreateUser: User?

    init() {}

    func create(_ user: User) async throws(RegisterUserError) {
        createWasCalled = true
        lastCreateUser = user

        try createResult.get()
    }

}
