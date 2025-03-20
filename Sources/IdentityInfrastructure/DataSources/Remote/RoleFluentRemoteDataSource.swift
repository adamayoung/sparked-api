//
//  RoleFluentRemoteDataSource.swift
//  AdamDateApp
//
//  Created by Adam Young on 19/03/2025.
//

import Fluent
import Foundation
import IdentityApplication
import IdentityDomain

package final class RoleFluentRemoteDataSource: RoleRemoteDataSource {

    private let database: any Database

    package init(database: some Database) {
        self.database = database
    }

    func create(_ role: Role) async throws(RoleRepositoryError) {
        let roleModel = RoleModelMapper.map(from: role)

        do {
            try await roleModel.save(on: database)
        } catch let error {
            throw .unknown(error)
        }
    }

    func addRole(_ role: Role, toUser user: User) async throws(RoleRepositoryError) {
        let userModel: UserModel?
        do {
            userModel = try await UserModel.find(user.id, on: database)
        } catch let error {
            throw .unknown(error)
        }

        guard let userModel else {
            throw .userNotFound
        }

        let roleModel: RoleModel?
        do {
            roleModel = try await RoleModel.find(role.id, on: database)
        } catch let error {
            throw .unknown(error)
        }

        guard let roleModel else {
            throw .notFound
        }

        do {
            try await userModel.$roles.attach(roleModel, on: database)
        } catch let error {
            throw .unknown(error)
        }
    }

    func addRoles(_ roles: [Role], toUser user: User) async throws(RoleRepositoryError) {
        for role in roles {
            try await addRole(role, toUser: user)
        }
    }

    func fetchAll() async throws(RoleRepositoryError) -> [Role] {
        let roleModels: [RoleModel]
        do {
            roleModels = try await RoleModel.query(on: database).all()
        } catch let error {
            throw .unknown(error)
        }

        let roles: [Role]
        do {
            roles = try roleModels.map(RoleMapper.map)
        } catch let error {
            throw .unknown(error)
        }

        return roles
    }

    func fetchAll(forUserID userID: User.ID) async throws(RoleRepositoryError) -> [Role] {
        let userModel: UserModel?
        do {
            userModel = try await UserModel.find(userID, on: database)
        } catch let error {
            throw .unknown(error)
        }

        guard let userModel else {
            throw .userNotFound
        }

        let roleModels: [RoleModel]
        do {
            roleModels = try await userModel.$roles.get(on: database)
        } catch let error {
            throw .unknown(error)
        }

        let roles: [Role]
        do {
            roles = try roleModels.map(RoleMapper.map)
        } catch let error {
            throw .unknown(error)
        }

        return roles
    }

    func fetch(byID id: Role.ID) async throws(RoleRepositoryError) -> Role {
        let roleModel: RoleModel?
        do {
            roleModel = try await RoleModel.find(id, on: database)
        } catch let error {
            throw .unknown(error)
        }

        guard let roleModel else {
            throw .notFound
        }

        let role: Role
        do {
            role = try RoleMapper.map(from: roleModel)
        } catch let error {
            throw .unknown(error)
        }

        return role
    }

    func fetch(byCode code: String) async throws(RoleRepositoryError) -> Role {
        let roleModel: RoleModel?
        do {
            roleModel = try await RoleModel.query(on: database)
                .filter(\.$code == code)
                .first()
        } catch let error {
            throw .unknown(error)
        }

        guard let roleModel else {
            throw .notFound
        }

        let role: Role
        do {
            role = try RoleMapper.map(from: roleModel)
        } catch let error {
            throw .unknown(error)
        }

        return role
    }

    func delete(byID id: Role.ID) async throws(RoleRepositoryError) {
        let roleModel: RoleModel?
        do {
            roleModel = try await RoleModel.find(id, on: database)
        } catch let error {
            throw .unknown(error)
        }

        guard let roleModel else {
            throw .notFound
        }

        do {
            try await roleModel.delete(on: database)
        } catch let error {
            throw .unknown(error)
        }
    }

}
