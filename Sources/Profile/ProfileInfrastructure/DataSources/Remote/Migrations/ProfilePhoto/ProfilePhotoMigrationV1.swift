//
//  ProfilePhotoMigrationV1.swift
//  SparkedAPI
//
//  Created by Adam Young on 06/03/2025.
//

import Fluent
import Foundation

struct ProfilePhotoMigrationV1: AsyncMigration {

    func prepare(on database: any Database) async throws {
        try await database.schema("profile_profile_photo")
            .id()
            .field("profile_id", .uuid, .required)
            .field("photo_index", .int, .required)
            .field("filename", .string, .required)
            .field("owner_id", .uuid, .required)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .field("deleted_at", .datetime)
            .unique(on: "filename")
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("profile_profile_photo").delete()
    }

}
