//
//  UserDefaultRoleRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 19/03/2025.
//

import Foundation
import IdentityApplication
import IdentityDomain

final class RoleDefaultRepository: RoleRepository {

    private let remoteDataSource: any RoleRemoteDataSource

    init(remoteDataSource: some RoleRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func create(_ role: Role) async throws(RoleRepositoryError) {
        try await remoteDataSource.create(role)
    }

    func addRole(_ role: Role, toUser user: User) async throws(RoleRepositoryError) {
        try await remoteDataSource.addRole(role, toUser: user)
    }

    func addRoles(_ roles: [Role], toUser user: User) async throws(RoleRepositoryError) {
        try await remoteDataSource.addRoles(roles, toUser: user)
    }

    func fetchAll() async throws(RoleRepositoryError) -> [Role] {
        try await remoteDataSource.fetchAll()
    }

    func fetchAll(forUserID userID: User.ID) async throws(RoleRepositoryError) -> [Role] {
        try await remoteDataSource.fetchAll(forUserID: userID)
    }

    func fetch(byID id: Role.ID) async throws(RoleRepositoryError) -> Role {
        try await remoteDataSource.fetch(byID: id)
    }

    func fetch(byCode code: String) async throws(RoleRepositoryError) -> Role {
        try await remoteDataSource.fetch(byCode: code)
    }

    func delete(byID id: Role.ID) async throws(RoleRepositoryError) {
        try await remoteDataSource.delete(byID: id)
    }

}
