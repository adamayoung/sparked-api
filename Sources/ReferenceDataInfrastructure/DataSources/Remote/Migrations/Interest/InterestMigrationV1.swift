//
//  InterestMigrationV1.swift
//  AdamDateApp
//
//  Created by Adam Young on 12/03/2025.
//

import Fluent
import Foundation

struct InterestMigrationV1: AsyncMigration {

    func prepare(on database: Database) async throws {
        try await database.schema("interest")
            .id()
            .field("name", .string, .required)
            .field("name_key", .string, .required)
            .field("glyph", .string, .required)
            .field(
                "interest_group_id",
                .uuid,
                .required,
                .references("interest_group", "id")
            )
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .field("deleted_at", .datetime)
            .unique(on: "name", "interest_group_id")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("interest").delete()
    }

}
