//
//  BasicProfileMigrationV1.swift
//  AdamDateApp
//
//  Created by Adam Young on 23/01/2025.
//

import Fluent
import Foundation

struct BasicProfileMigrationV1: AsyncMigration {

    func prepare(on database: Database) async throws {
        try await database.schema("profile_basic_profile")
            .id()
            .field("display_name", .string, .required)
            .field("birth_date", .date, .required)
            .field("bio", .string, .required)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .field("deleted_at", .datetime)
            .field("owner_id", .uuid, .required)
            .unique(on: "owner_id")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("profile_basic_profile").delete()
    }

}
