//
//  BasicInfoMigrationV1.swift
//  AdamDateApp
//
//  Created by Adam Young on 11/02/2025.
//

import Fluent
import Foundation

struct BasicInfoMigrationV1: AsyncMigration {

    func prepare(on database: Database) async throws {
        try await database.schema("basic_info")
            .id()
            .field("user_id", .uuid, .required)
            .field("profile_id", .uuid, .required)
            .field("gender_id", .uuid, .required)
            .field("country_id", .uuid, .required)
            .field("location", .string, .required)
            .field("home_town", .string)
            .field("workplace", .string)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .field("deleted_at", .datetime)
            .unique(on: "user_id")
            .unique(on: "profile_id")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("basic_info").delete()
    }

}
