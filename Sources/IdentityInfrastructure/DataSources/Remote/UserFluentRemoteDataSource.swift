//
//  UserFluentRemoteDataSource.swift
//  SparkedAPI
//
//  Created by Adam Young on 05/02/2025.
//

import Fluent
import Foundation
import IdentityApplication
import IdentityDomain

package final class UserFluentRemoteDataSource: UserRemoteDataSource {

    private let database: any Database

    package init(database: some Database) {
        self.database = database
    }

    func create(_ user: User, withRoles roles: [Role]) async throws(UserRepositoryError) {
        guard (try? await self.fetch(byEmail: user.email)) == nil else {
            throw .duplicateEmail
        }

        do {
            try await database.transaction { database in
                let userModel = UserModelMapper.map(from: user)
                try await userModel.save(on: database)

                for role in roles {
                    guard let roleModel = try await RoleModel.find(role.id, on: database) else {
                        throw UserRepositoryError.roleNotFound
                    }
                    try await userModel.$roles.attach(roleModel, on: database)
                }
            }
        } catch let error as UserRepositoryError {
            throw error
        } catch let error {
            throw .unknown(error)
        }
    }

    package func fetch(byID id: User.ID) async throws(UserRepositoryError) -> User {
        let userModel: UserModel?
        do {
            userModel = try await UserModel.find(id, on: database)
        } catch let error {
            throw .unknown(error)
        }

        guard let userModel else {
            throw .notFound
        }

        let user: User
        do {
            user = try UserMapper.map(from: userModel)
        } catch let error {
            throw .unknown(error)
        }

        return user
    }

    package func fetch(byEmail email: String) async throws(UserRepositoryError) -> User {
        let userModel: UserModel?
        do {
            userModel = try await UserModel.query(on: database)
                .filter(\.$email == email).first()
        } catch let error {
            throw .unknown(error)
        }

        guard let userModel else {
            throw .notFound
        }

        let user: User
        do {
            user = try UserMapper.map(from: userModel)
        } catch let error {
            throw .unknown(error)
        }

        return user
    }

}
