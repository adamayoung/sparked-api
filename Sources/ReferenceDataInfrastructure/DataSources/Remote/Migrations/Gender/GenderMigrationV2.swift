//
//  GenderMigrationV2.swift
//  AdamDateApp
//
//  Created by Adam Young on 13/03/2025.
//

import Fluent
import Foundation

struct GenderMigrationV2: AsyncMigration {

    func prepare(on database: Database) async throws {
        try await database.transaction { database in
            for gender in Self.genders {
                try await gender.save(on: database)
            }
        }
    }

    func revert(on database: Database) async throws {
        try await database.transaction { database in
            for gender in Self.genders {
                try await GenderModel
                    .find(gender.requireID(), on: database)?
                    .delete(force: true, on: database)
            }
        }
    }

}

extension GenderMigrationV2 {

    static let genders = [
        GenderModel(
            id: UUID(uuidString: "D4906FA3-CDA1-4F0B-9631-809314451110"),
            code: "M",
            name: "Male"
        ),
        GenderModel(
            id: UUID(uuidString: "9FE92837-AADC-4D54-8A98-479C4EE57FA8"),
            code: "F",
            name: "Female"
        ),
        GenderModel(
            id: UUID(uuidString: "FD322FBC-48E3-461F-852A-B899D5F50691"),
            code: "O",
            name: "Other"
        )
    ]

}
