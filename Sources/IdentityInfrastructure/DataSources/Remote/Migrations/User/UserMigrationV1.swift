//
//  UserMigrationV1.swift
//  AdamDateApp
//
//  Created by Adam Young on 23/01/2025.
//

import Fluent
import Foundation

struct UserMigrationV1: AsyncMigration {

    func prepare(on database: Database) async throws {
        try await database.schema("identity_user")
            .id()
            .field("first_name", .string, .required)
            .field("family_name", .string, .required)
            .field("email", .string, .required)
            .field("password", .string, .required)
            .field("is_verified", .bool, .required)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .field("deleted_at", .datetime)
            .unique(on: "email")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("identity_user").delete()
    }

}
