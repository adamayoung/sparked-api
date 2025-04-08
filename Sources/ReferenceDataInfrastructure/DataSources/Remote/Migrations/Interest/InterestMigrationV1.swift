//
//  InterestMigrationV1.swift
//  SparkedAPI
//
//  Created by Adam Young on 12/03/2025.
//

import Fluent
import Foundation

struct InterestMigrationV1: AsyncMigration {

    func prepare(on database: any Database) async throws {
        try await database.schema("reference_data_interest")
            .id()
            .field("name", .string, .required)
            .field("name_key", .string, .required)
            .field("glyph", .string, .required)
            .field(
                "interest_group_id",
                .uuid,
                .required,
                .references("reference_data_interest_group", "id")
            )
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .field("deleted_at", .datetime)
            .unique(on: "name", "interest_group_id")
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("reference_data_interest").delete()
    }

}
