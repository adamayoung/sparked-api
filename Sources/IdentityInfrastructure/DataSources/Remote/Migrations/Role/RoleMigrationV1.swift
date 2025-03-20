//
//  RoleMigrationV1.swift
//  AdamDateApp
//
//  Created by Adam Young on 19/03/2025.
//

import Fluent
import Foundation

struct RoleMigrationV1: AsyncMigration {

    func prepare(on database: Database) async throws {
        try await database.schema("identity_role")
            .id()
            .field("name", .string, .required)
            .field("code", .string, .required)
            .field("description", .string, .required)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .field("deleted_at", .datetime)
            .unique(on: "name")
            .unique(on: "code")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("identity_role").delete()
    }

}
