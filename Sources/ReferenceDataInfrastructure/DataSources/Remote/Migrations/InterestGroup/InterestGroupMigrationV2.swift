//
//  InterestGroupMigrationV2.swift
//  AdamDateApp
//
//  Created by Adam Young on 13/03/2025.
//

import Fluent
import Foundation

struct InterestGroupMigrationV2: AsyncMigration {

    func prepare(on database: Database) async throws {
        try await database.transaction { database in
            for (_, interestGroup) in Self.interestGroups {
                try await interestGroup.save(on: database)
            }
        }
    }

    func revert(on database: Database) async throws {
        for (_, interestGroup) in Self.interestGroups {
            try await InterestGroupModel
                .find(interestGroup.requireID(), on: database)?
                .delete(force: true, on: database)
        }
    }

}

extension InterestGroupMigrationV2 {

    static let interestGroups: [String: InterestGroupModel] = [
        "Self-care": InterestGroupModel(
            id: UUID(uuidString: "1FF42505-76AC-4C6A-9AC4-7EC99B667048"),
            name: "Self-care"
        ),
        "Sports": InterestGroupModel(
            id: UUID(uuidString: "9B2C5E73-0F3E-41EF-83BA-2F91E86F85EE"),
            name: "Sports"
        ),
        "Creativity": InterestGroupModel(
            id: UUID(uuidString: "A66BC604-4107-4D5E-B3CC-80508DDF0E43"),
            name: "Creativity"
        )
    ]

}
