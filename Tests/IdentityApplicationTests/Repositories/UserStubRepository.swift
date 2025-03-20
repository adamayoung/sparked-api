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
    private(set) var lastCreateUser: User?

    var fetchByIDResult: Result<User, UserRepositoryError> = .failure(.unknown(nil))
    private(set) var fetchByIDWasCalled = false
    private(set) var lastFetchByIDID: User.ID?

    var fetchByEmailResult: Result<User, UserRepositoryError> = .failure(.unknown(nil))
    private(set) var fetchByEmailWasCalled = false
    private(set) var lastFetchByEmailEmail: String?

    init() {}

    func create(_ user: User) async throws(UserRepositoryError) {
        createWasCalled = true
        lastCreateUser = user

        try createResult.get()
    }

    func create(_ user: User, withRoles roles: [Role]) async throws(UserRepositoryError) {
        // TODO: create
    }

    func fetch(byID id: User.ID) async throws(UserRepositoryError) -> User {
        fetchByIDWasCalled = true
        lastFetchByIDID = id

        return try fetchByIDResult.get()
    }

    func fetch(byEmail email: String) async throws(UserRepositoryError) -> User {
        fetchByEmailWasCalled = true
        lastFetchByEmailEmail = email

        return try fetchByEmailResult.get()
    }

}
