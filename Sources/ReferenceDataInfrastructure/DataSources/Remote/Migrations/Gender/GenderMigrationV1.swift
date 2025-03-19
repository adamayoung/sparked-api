//
//  GenderMigrationV1.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Fluent
import Foundation

struct GenderMigrationV1: AsyncMigration {

    func prepare(on database: Database) async throws {
        try await database.schema("gender")
            .id()
            .field("code", .string, .required)
            .field("name", .string, .required)
            .field("name_key", .string, .required)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .field("deleted_at", .datetime)
            .unique(on: "code")
            .unique(on: "name")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("gender").delete()
    }

}
