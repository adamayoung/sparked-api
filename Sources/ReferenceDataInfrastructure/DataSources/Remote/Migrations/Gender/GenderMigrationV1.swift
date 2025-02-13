//
//  GenderMigrationV1.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Fluent
import Foundation

struct GenderMigrationV1: AsyncMigration {

    func prepare(on database: Database) async throws {
        try await database.schema("gender")
            .id()
            .field("code", .string, .required)
            .field("name", .string, .required)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .field("deleted_at", .datetime)
            .unique(on: "code")
            .unique(on: "name")
            .create()

        try await database.transaction { database in
            let maleGender = GenderModel(code: "M", name: "Male")
            try await maleGender.save(on: database)

            let femaleGender = GenderModel(code: "F", name: "Female")
            try await femaleGender.save(on: database)

            let otherGender = GenderModel(code: "O", name: "Other")
            try await otherGender.save(on: database)
        }
    }

    func revert(on database: Database) async throws {
        try await database.schema("gender").delete()
    }

}
