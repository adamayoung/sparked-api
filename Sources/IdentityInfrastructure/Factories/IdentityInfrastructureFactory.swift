//
//  IdentityInfrastructureFactory.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/02/2025.
//

import Fluent
import Foundation
import IdentityApplication

package final class IdentityInfrastructureFactory: Sendable {

    private init() {}

    package static func makeUserRepository(database: some Database) -> some UserRepository {
        let remoteDataSource = Self.makeUserDataSource(database: database)

        return UserDefaultRepository(remoteDataSource: remoteDataSource)
    }

    package static func makeRoleRepository(database: some Database) -> some RoleRepository {
        let remoteDataSource = Self.makeRoleDataSource(database: database)

        return RoleDefaultRepository(remoteDataSource: remoteDataSource)
    }

    package static func makeMigrations() -> [Migration] {
        IdentityMigrations.all()
    }

}

extension IdentityInfrastructureFactory {

    private static func makeUserDataSource(database: some Database) -> some UserRemoteDataSource {
        UserFluentRemoteDataSource(database: database)
    }

    private static func makeRoleDataSource(database: some Database) -> some RoleRemoteDataSource {
        RoleFluentRemoteDataSource(database: database)
    }

}
