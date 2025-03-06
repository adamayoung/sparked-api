//
//  ProfilePhotoMigrationV1.swift
//  AdamDateApp
//
//  Created by Adam Young on 06/03/2025.
//

import Fluent
import Foundation

struct ProfilePhotoMigrationV1: AsyncMigration {

    func prepare(on database: Database) async throws {
        try await database.schema("profile_photo")
            .id()
            .field("user_id", .uuid, .required)
            .field("profile_id", .uuid, .required)
            .field("photo_index", .int, .required)
            .field("filename", .string, .required)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .field("deleted_at", .datetime)
            .unique(on: "filename")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("profile_photo").delete()
    }

}
