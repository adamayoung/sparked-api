//
//  InterestGroupMigrationV1.swift
//  AdamDateApp
//
//  Created by Adam Young on 12/03/2025.
//

import Fluent
import Foundation

struct InterestGroupMigrationV1: AsyncMigration {

    func prepare(on database: Database) async throws {
        try await database.schema("interest_group")
            .id()
            .field("name", .string, .required)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .field("deleted_at", .datetime)
            .unique(on: "name")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("interest_group").delete()
    }

}
