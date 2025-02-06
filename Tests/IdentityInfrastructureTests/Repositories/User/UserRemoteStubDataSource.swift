//
//  UserRemoteStubDataSource.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation
import IdentityApplication
import IdentityDomain
import IdentityInfrastructure

final class UserRemoteStubDataSource: UserRemoteDataSource {

    var createResult: Result<User, RegisterUserError> = .failure(.unknown())
    private(set) var createWasCalled = false
    private(set) var lastCreateUser: User?

    var fetchByIDResult: Result<User, FetchUserError> = .failure(.unknown())
    private(set) var fetchByIDWasCalled = false
    private(set) var lastFetchByIDID: User.ID?

    var fetchByEmailResult: Result<User, FetchUserError> = .failure(.unknown())
    private(set) var fetchByEmailWasCalled = false
    private(set) var lastFetchByEmailEmail: String?

    init() {}

    func create(user: User) async throws(RegisterUserError) -> User {
        createWasCalled = true
        lastCreateUser = user

        return try createResult.get()
    }

    func fetch(byID id: User.ID) async throws(FetchUserError) -> User {
        fetchByIDWasCalled = true
        lastFetchByIDID = id

        return try fetchByIDResult.get()
    }

    func fetch(byEmail email: String) async throws(FetchUserError) -> User {
        fetchByEmailWasCalled = true
        lastFetchByEmailEmail = email

        return try fetchByEmailResult.get()
    }

}
