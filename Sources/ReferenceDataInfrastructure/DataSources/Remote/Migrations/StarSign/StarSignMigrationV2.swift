//
//  StarSignMigrationV2.swift
//  SparkedAPI
//
//  Created by Adam Young on 18/03/2025.
//

import Fluent
import Foundation

struct StarSignMigrationV2: AsyncMigration {

    func prepare(on database: any Database) async throws {
        try await database.transaction { database in
            for starSign in Self.starSigns {
                try await starSign.save(on: database)
            }
        }
    }

    func revert(on database: any Database) async throws {
        for starSign in Self.starSigns {
            try await StarSignModel
                .find(starSign.requireID(), on: database)?
                .delete(force: true, on: database)
        }
    }

}

extension StarSignMigrationV2 {

    static let starSigns: [StarSignModel] = [
        StarSignModel(
            id: UUID(uuidString: "8F535ADF-EC5B-42BC-B410-AD5D633363EA"),
            name: "Aries",
            nameKey: "REFERENCE_DATA.STAR_SIGN.ARIES",
            glyph: "♈️",
            index: 0
        ),
        StarSignModel(
            id: UUID(uuidString: "7D0F2586-C254-45AC-A50D-ECF5A2CE868F"),
            name: "Taurus",
            nameKey: "REFERENCE_DATA.STAR_SIGN.TAURUS",
            glyph: "♉️",
            index: 1
        ),
        StarSignModel(
            id: UUID(uuidString: "F86D4D2A-74AD-4664-995D-FFCFB7B52E3A"),
            name: "Gemini",
            nameKey: "REFERENCE_DATA.STAR_SIGN.GENMI",
            glyph: "♊️",
            index: 2
        ),
        StarSignModel(
            id: UUID(uuidString: "566C4E1C-7CD2-47EA-83C9-04F04360BE07"),
            name: "Cancer",
            nameKey: "REFERENCE_DATA.STAR_SIGN.CANCER",
            glyph: "♋️",
            index: 3
        ),
        StarSignModel(
            id: UUID(uuidString: "750486BC-17F3-457F-8846-6604F3CC9C45"),
            name: "Leo",
            nameKey: "REFERENCE_DATA.STAR_SIGN.LEO",
            glyph: "♌️",
            index: 4
        ),
        StarSignModel(
            id: UUID(uuidString: "F42AD1F2-3429-4F05-A51B-5D3A12A9EEA1"),
            name: "Virgo",
            nameKey: "REFERENCE_DATA.STAR_SIGN.VIRGO",
            glyph: "♍️",
            index: 5
        ),
        StarSignModel(
            id: UUID(uuidString: "75362B6B-4092-4D7B-B111-6550911F6D1C"),
            name: "Libra",
            nameKey: "REFERENCE_DATA.STAR_SIGN.LIBRA",
            glyph: "♎️",
            index: 6
        ),
        StarSignModel(
            id: UUID(uuidString: "2D9E94A4-32B0-4D63-ABA4-16E1EAB80BD1"),
            name: "Scorpio",
            nameKey: "REFERENCE_DATA.STAR_SIGN.SCORPIO",
            glyph: "♏️",
            index: 7
        ),
        StarSignModel(
            id: UUID(uuidString: "B4E3FD7D-6C9C-4794-A07B-BD6232036112"),
            name: "Sagittarius",
            nameKey: "REFERENCE_DATA.STAR_SIGN.SAGITTARIUS",
            glyph: "♐️",
            index: 8
        ),
        StarSignModel(
            id: UUID(uuidString: "8DA2C582-459B-441B-B69F-2292349370D0"),
            name: "Capricorn",
            nameKey: "REFERENCE_DATA.STAR_SIGN.CAPRICORN",
            glyph: "♑️",
            index: 9
        ),
        StarSignModel(
            id: UUID(uuidString: "8BCA492D-1F7F-4B62-8891-188312BC1941"),
            name: "Aquarius",
            nameKey: "REFERENCE_DATA.STAR_SIGN.AQUARIUS",
            glyph: "♒️",
            index: 10
        ),
        StarSignModel(
            id: UUID(uuidString: "7B4EF404-57D6-4528-9C70-66CFF927ABCC"),
            name: "Pisces",
            nameKey: "REFERENCE_DATA.STAR_SIGN.PISCES",
            glyph: "♓️",
            index: 11
        )
    ]

}
