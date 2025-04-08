//
//  ProfileInterestMigrationV1.swift
//  SparkedAPI
//
//  Created by Adam Young on 17/03/2025.
//

import Fluent
import Foundation

struct ProfileInterestMigrationV1: AsyncMigration {

    func prepare(on database: any Database) async throws {
        try await database.schema("profile_profile_interest")
            .id()
            .field("profile_id", .uuid, .required)
            .field("interest_id", .uuid, .required)
            .field("owner_id", .uuid, .required)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .field("deleted_at", .datetime)
            .unique(on: "profile_id", "interest_id")
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("profile_profile_interest").delete()
    }

}
