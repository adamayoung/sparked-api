//
//  InterestMigrationV2.swift
//  AdamDateApp
//
//  Created by Adam Young on 13/03/2025.
//

import Fluent
import Foundation

struct InterestMigrationV2: AsyncMigration {

    func prepare(on database: Database) async throws {
        try await database.transaction { database in
            for (interestGroupName, interests) in Self.interests {
                guard
                    let interestGroup = InterestGroupMigrationV2.interestGroups[interestGroupName]
                else {
                    database.logger.error("Cannot find interest group \(interestGroupName)")
                    continue
                }

                for interest in interests {
                    interest.$interestGroup.id = try interestGroup.requireID()
                    try await interest.save(on: database)
                }
            }
        }
    }

    func revert(on database: Database) async throws {
        for (_, interests) in Self.interests {
            for interest in interests {
                try await InterestModel
                    .find(interest.requireID(), on: database)?
                    .delete(force: true, on: database)
            }
        }
    }

}

extension InterestMigrationV2 {

    static let interests: [String: [InterestModel]] = [
        "Self-care": selfCareInterests,
        "Sports": sportsInterests,
        "Creativity": creativityInterests
    ]

    static let selfCareInterests = [
        InterestModel(
            id: UUID(uuidString: "2E76C0FE-7BCD-4047-BC64-47C14927DA27"),
            name: "Aromatherapy",
            glyph: "🕯️"
        ),
        InterestModel(
            id: UUID(uuidString: "A6D13A10-9BED-456B-8AA7-C1FB5452325A"),
            name: "Astrology",
            glyph: "💫"
        ),
        InterestModel(
            id: UUID(uuidString: "E2DF4AA9-2582-48F2-8460-7548B9E69F3C"),
            name: "Cold plunging",
            glyph: "🧊"
        ),
        InterestModel(
            id: UUID(uuidString: "4F2136E5-6681-4E48-B95A-D14E2C011254"),
            name: "Deep chats",
            glyph: "💬"
        )
    ]

    static let sportsInterests = [
        InterestModel(
            id: UUID(uuidString: "59ABDCE5-A5F7-4760-9367-5E5F211662A6"),
            name: "American football",
            glyph: "🏈"
        ),
        InterestModel(
            id: UUID(uuidString: "D1F188FB-05D7-4358-A965-469E1E8F6ECD"),
            name: "Athletics",
            glyph: "🎽"
        ),
        InterestModel(
            id: UUID(uuidString: "02490E10-4010-4567-A96D-59B0902BE80A"),
            name: "Badminton",
            glyph: "🏸"
        ),
        InterestModel(
            id: UUID(uuidString: "408770A5-65E7-47E7-AC24-C9311B088535"),
            name: "Football",
            glyph: "⚽️"
        )
    ]

    static let creativityInterests = [
        InterestModel(
            id: UUID(uuidString: "219A84F3-CEA9-498E-8492-9D0FA925FF9F"),
            name: "Art",
            glyph: "🎨"
        ),
        InterestModel(
            id: UUID(uuidString: "CB9FCD47-F510-4E99-A2F8-7A2B741A6A06"),
            name: "Crafts",
            glyph: "🧷"
        ),
        InterestModel(
            id: UUID(uuidString: "CE73EA1F-F795-4242-852C-0AB85DE8765C"),
            name: "Dancing",
            glyph: "💃"
        )
    ]

}
