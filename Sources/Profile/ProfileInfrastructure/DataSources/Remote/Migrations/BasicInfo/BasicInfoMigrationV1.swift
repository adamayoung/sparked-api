//
//  BasicInfoMigrationV1.swift
//  SparkedAPI
//
//  Created by Adam Young on 11/02/2025.
//

import Fluent
import Foundation

struct BasicInfoMigrationV1: AsyncMigration {

    func prepare(on database: any Database) async throws {
        try await database.schema("profile_basic_info")
            .id()
            .field("profile_id", .uuid, .required)
            .field("gender_id", .uuid, .required)
            .field("country_id", .uuid, .required)
            .field("location", .string, .required)
            .field("home_town", .string)
            .field("workplace", .string)
            .field("owner_id", .uuid, .required)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .field("deleted_at", .datetime)
            .unique(on: "profile_id")
            .unique(on: "owner_id")
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("profile_basic_info").delete()
    }

}
