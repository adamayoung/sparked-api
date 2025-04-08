//
//  ExtendedInfoMigrationV1.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Fluent
import Foundation

struct ExtendedInfoMigrationV1: AsyncMigration {

    func prepare(on database: any Database) async throws {
        try await database.schema("profile_extended_info")
            .id()
            .field("profile_id", .uuid, .required)
            .field("height", .double)
            .field("education_level_id", .uuid)
            .field("star_sign_id", .uuid)
            .field("owner_id", .uuid, .required)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .field("deleted_at", .datetime)
            .unique(on: "profile_id")
            .unique(on: "owner_id")
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("profile_extended_info").delete()
    }

}
