//
//  UserRoleMigrationV1.swift
//  SparkedAPI
//
//  Created by Adam Young on 19/03/2025.
//

import Fluent
import Foundation

struct UserRoleMigrationV1: AsyncMigration {

    func prepare(on database: any Database) async throws {
        try await database.schema("identity_user+role")
            .id()
            .field("user_id", .uuid, .required)
            .field("role_id", .uuid, .required)
            .unique(on: "user_id", "role_id")
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("identity_user+role").delete()
    }

}
