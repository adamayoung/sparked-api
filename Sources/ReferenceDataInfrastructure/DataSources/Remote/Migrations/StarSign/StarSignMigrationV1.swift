//
//  StarSignMigrationV1.swift
//  SparkedAPI
//
//  Created by Adam Young on 18/03/2025.
//

import Fluent
import Foundation

struct StarSignMigrationV1: AsyncMigration {

    func prepare(on database: any Database) async throws {
        try await database.schema("reference_data_star_sign")
            .id()
            .field("name", .string, .required)
            .field("name_key", .string, .required)
            .field("glyph", .string, .required)
            .field("index", .int, .required)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .field("deleted_at", .datetime)
            .unique(on: "name")
            .unique(on: "glyph")
            .unique(on: "index")
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("reference_data_star_sign").delete()
    }

}
