//
//  InterestGroupMigrationV2.swift
//  SparkedAPI
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
            name: "Self-care",
            nameKey: "REFERENCE_DATA.INTEREST_GROUP.SELF_CARE"
        ),
        "Sports": InterestGroupModel(
            id: UUID(uuidString: "9B2C5E73-0F3E-41EF-83BA-2F91E86F85EE"),
            name: "Sports",
            nameKey: "REFERENCE_DATA.INTEREST_GROUP.SPORTS"
        ),
        "Creativity": InterestGroupModel(
            id: UUID(uuidString: "A66BC604-4107-4D5E-B3CC-80508DDF0E43"),
            name: "Creativity",
            nameKey: "REFERENCE_DATA.INTEREST_GROUP.CREATIVITY"
        ),
        "Going out": InterestGroupModel(
            id: UUID(uuidString: "EC2AAFA0-DA80-43D4-9E37-0D991F7432A1"),
            name: "Going out",
            nameKey: "REFERENCE_DATA.INTEREST_GROUP.GOING_OUT"
        ),
        "Staying in": InterestGroupModel(
            id: UUID(uuidString: "828889E6-39BF-42AE-AE5B-786A5BA7E0A2"),
            name: "Staying in",
            nameKey: "REFERENCE_DATA.INTEREST_GROUP.STARING_IN"
        ),
        "Film and TV": InterestGroupModel(
            id: UUID(uuidString: "E988D3B5-90F8-4B4F-A18F-3AB5645BF0E9"),
            name: "Film and TV",
            nameKey: "REFERENCE_DATA.INTEREST_GROUP.FILM_AND_TV"
        ),
        "Reading": InterestGroupModel(
            id: UUID(uuidString: "00997045-8926-4E7D-B017-928265312E63"),
            name: "Reading",
            nameKey: "REFERENCE_DATA.INTEREST_GROUP.READING"
        ),
        "Music": InterestGroupModel(
            id: UUID(uuidString: "819BE414-FA57-4B68-879D-A16C668D734D"),
            name: "Music",
            nameKey: "REFERENCE_DATA.INTEREST_GROUP.MUSIC"
        ),
        "Food and drink": InterestGroupModel(
            id: UUID(uuidString: "789A8D86-424E-4901-8741-FAB0D1BDA258"),
            name: "Food and drink",
            nameKey: "REFERENCE_DATA.INTEREST_GROUP.FOOD_AND_DRINK"
        ),
        "Travelling": InterestGroupModel(
            id: UUID(uuidString: "38F64FE9-51AF-4F03-9863-9F7D7F9200C9"),
            name: "Travelling",
            nameKey: "REFERENCE_DATA.INTEREST_GROUP.TRAVELLING"
        ),
        "Pets": InterestGroupModel(
            id: UUID(uuidString: "94DA0237-6A0D-4158-9B28-45FD0974E3F6"),
            name: "Pets",
            nameKey: "REFERENCE_DATA.INTEREST_GROUP.PETS"
        ),
        "Personality and traits": InterestGroupModel(
            id: UUID(uuidString: "18F4430B-0F40-4BED-8D12-A93FAC60C0A5"),
            name: "Personality and traits",
            nameKey: "REFERENCE_DATA.INTEREST_GROUP.PERSONALITY_AND_TRAITS"
        ),
        "Values and allyship": InterestGroupModel(
            id: UUID(uuidString: "4B28876B-A4A8-4CB6-816D-40448CC06901"),
            name: "Values and allyship",
            nameKey: "REFERENCE_DATA.INTEREST_GROUP.VALUES_AND_ALLYSHIP"
        )
    ]

}
