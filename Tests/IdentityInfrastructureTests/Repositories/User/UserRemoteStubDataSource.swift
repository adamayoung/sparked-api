//
//  UserRemoteStubDataSource.swift
//  SparkedAPI
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation
import IdentityApplication
import IdentityDomain

@testable import IdentityInfrastructure

final class UserRemoteStubDataSource: UserRemoteDataSource {

    var createResult: Result<Void, UserRepositoryError> = .failure(.unknown())
    private(set) var createWasCalled = false
    private(set) var lastCreateParameters: (user: User, roles: [Role])?

    var fetchByIDResult: Result<User, UserRepositoryError> = .failure(.unknown())
    private(set) var fetchByIDWasCalled = false
    private(set) var lastFetchByIDID: User.ID?

    var fetchByEmailResult: Result<User, UserRepositoryError> = .failure(.unknown())
    private(set) var fetchByEmailWasCalled = false
    private(set) var lastFetchByEmailEmail: String?

    init() {}

    func create(
        _ user: User,
        withRoles roles: [Role]
    ) async throws(UserRepositoryError) {
        createWasCalled = true
        lastCreateParameters = (user: user, roles: roles)

        try createResult.get()
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
