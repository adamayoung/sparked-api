//
//  ProfileInterestMigrationV1.swift
//  AdamDateApp
//
//  Created by Adam Young on 17/03/2025.
//

import Fluent
import Foundation

struct ProfileInterestMigrationV1: AsyncMigration {

    func prepare(on database: Database) async throws {
        try await database.schema("profile_interest")
            .id()
            .field("user_id", .uuid, .required)
            .field("profile_id", .uuid, .required)
            .field("interest_id", .uuid, .required)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .field("deleted_at", .datetime)
            .unique(on: "profile_id", "interest_id")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("profile_interest").delete()
    }

}
