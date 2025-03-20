//
//  RegisterUserStubRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 29/01/2025.
//

import Foundation
import IdentityDomain

@testable import IdentityApplication

final class UserStubRepository: UserRepository {

    var createResult: Result<Void, UserRepositoryError> = .failure(.unknown())
    private(set) var createWasCalled = false
    private(set) var lastCreateParameters: (user: User, roles: [Role])?

    var fetchByIDResult: Result<User, UserRepositoryError> = .failure(.unknown(nil))
    private(set) var fetchByIDWasCalled = false
    private(set) var lastFetchByIDParameter: User.ID?

    var fetchByEmailResult: Result<User, UserRepositoryError> = .failure(.unknown(nil))
    private(set) var fetchByEmailWasCalled = false
    private(set) var lastFetchByEmailParameter: String?

    init() {}

    func create(_ user: User, withRoles roles: [Role]) async throws(UserRepositoryError) {
        createWasCalled = true
        lastCreateParameters = (user: user, roles: roles)

        try createResult.get()
    }

    func fetch(byID id: User.ID) async throws(UserRepositoryError) -> User {
        fetchByIDWasCalled = true
        lastFetchByIDParameter = id

        return try fetchByIDResult.get()
    }

    func fetch(byEmail email: String) async throws(UserRepositoryError) -> User {
        fetchByEmailWasCalled = true
        lastFetchByEmailParameter = email

        return try fetchByEmailResult.get()
    }

}
