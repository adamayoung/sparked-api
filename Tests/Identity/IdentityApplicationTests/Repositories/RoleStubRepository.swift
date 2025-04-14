//
//  RoleStubRepository.swift
//  SparkedAPI
//
//  Created by Adam Young on 19/03/2025.
//

import Foundation
import IdentityDomain

@testable import IdentityApplication

final class RoleStubRepository: RoleRepository {

    var createResult: Result<Void, RoleRepositoryError> = .failure(.unknown())
    private(set) var createWasCalled = false
    private(set) var lastCreateParameter: Role?

    var addRoleResult: Result<Void, RoleRepositoryError> = .failure(.unknown())
    private(set) var addRoleWasCalled = false
    private(set) var lastAddRoleParameters: (role: Role, user: User)?

    var addRolesResult: Result<Void, RoleRepositoryError> = .failure(.unknown())
    private(set) var addRolesWasCalled = false
    private(set) var lastAddRolesParameters: (roles: [Role], user: User)?

    var fetchAllResult: Result<[Role], RoleRepositoryError> = .failure(.unknown())
    private(set) var fetchAllWasCalled = false

    var fetchAllForUserIDResult: Result<[Role], RoleRepositoryError> = .failure(.unknown())
    private(set) var fetchAllForUserIDWasCalled = false
    private(set) var lastFetchAllForUserIDParameter: UUID?

    var fetchByIDResult: Result<Role, RoleRepositoryError> = .failure(.unknown())
    private(set) var fetchByIDWasCalled = false
    private(set) var lastFetchByIDParameter: UUID?

    var fetchByCodeResult: Result<Role, RoleRepositoryError> = .failure(.unknown())
    private(set) var fetchByCodeWasCalled = false
    private(set) var lastFetchByCodeParameter: String?

    var deleteByIDResult: Result<Void, RoleRepositoryError> = .failure(.unknown())
    private(set) var deleteByIDWasCalled = false
    private(set) var lastDeleteByIDParameter: UUID?

    init() {}

    func create(_ role: Role) async throws(RoleRepositoryError) {
        createWasCalled = true
        lastCreateParameter = role

        return try createResult.get()
    }

    func addRole(_ role: Role, toUser user: User) async throws(RoleRepositoryError) {
        addRoleWasCalled = true
        lastAddRoleParameters = (role: role, user: user)

        return try addRoleResult.get()
    }

    func addRoles(_ roles: [Role], toUser user: User) async throws(RoleRepositoryError) {
        addRolesWasCalled = true
        lastAddRolesParameters = (roles: roles, user: user)

        return try addRolesResult.get()
    }

    func fetchAll() async throws(RoleRepositoryError) -> [Role] {
        fetchAllWasCalled = true

        return try fetchAllResult.get()
    }

    func fetchAll(forUserID userID: User.ID) async throws(RoleRepositoryError) -> [Role] {
        fetchAllForUserIDWasCalled = true
        lastFetchAllForUserIDParameter = userID

        return try fetchAllForUserIDResult.get()
    }

    func fetch(byID id: Role.ID) async throws(RoleRepositoryError) -> Role {
        fetchByIDWasCalled = true
        lastFetchByIDParameter = id

        return try fetchByIDResult.get()
    }

    func fetch(byCode code: String) async throws(RoleRepositoryError) -> Role {
        fetchByCodeWasCalled = true
        lastFetchByCodeParameter = code

        return try fetchByCodeResult.get()
    }

    func delete(byID id: Role.ID) async throws(RoleRepositoryError) {
        deleteByIDWasCalled = true
        lastDeleteByIDParameter = id

        return try deleteByIDResult.get()
    }

}
