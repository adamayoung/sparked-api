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

    fileprivate static let interests: [String: [InterestModel]] = [
        "Self-care": selfCareInterests,
        "Sports": sportsInterests,
        "Creativity": creativityInterests,
        "Going out": goingOutInterests,
        "Staying in": stayingInInterests,
        "Film and TV": filmAndTVInterests,
        "Reading": readingInterests,
        "Music": musicInterests,
        "Food and drink": foodAndDrinkInterests,
        "Travelling": travellingInterests,
        "Pets": petsInterests,
        "Personality and traits": personalityAndTraitsInterests,
        "Values and allyship": valuesAndAllyshipInterests
    ]

    fileprivate static let selfCareInterests = [
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
        ),
        InterestModel(
            id: UUID(uuidString: "D9F63C98-48F7-4602-A125-8638C7A54A9F"),
            name: "Journalling",
            glyph: "✍️"
        ),
        InterestModel(
            id: UUID(uuidString: "76DF59C4-23AA-46D1-961D-0BF14542F6D4"),
            name: "Mindfulness",
            glyph: "🧠"
        ),
        InterestModel(
            id: UUID(uuidString: "CD4077A5-9B95-446F-B149-C534FC60F3C9"),
            name: "Nutrition",
            glyph: "🥦"
        ),
        InterestModel(
            id: UUID(uuidString: "2FD98ECA-66D4-4A72-A0D9-DA77BCE31DDE"),
            name: "Retreats",
            glyph: "🧘"
        ),
        InterestModel(
            id: UUID(uuidString: "AA2C815D-2A6E-400E-AE40-E19C19D9C3BA"),
            name: "Skin care",
            glyph: "🧴"
        ),
        InterestModel(
            id: UUID(uuidString: "FC316E1F-96CC-465A-8FBE-A5286645C8C6"),
            name: "Sleeping well",
            glyph: "💤"
        ),
        InterestModel(
            id: UUID(uuidString: "B0F49C55-DC0D-4607-A979-FF8E8B77E971"),
            name: "Slow living",
            glyph: "🐌"
        ),
        InterestModel(
            id: UUID(uuidString: "701A784F-D4BE-4EE7-9935-FC657381990C"),
            name: "Therapy",
            glyph: "💛"
        ),
        InterestModel(
            id: UUID(uuidString: "71B52861-495E-42EC-B7A7-3264C40EF851"),
            name: "Time offline",
            glyph: "🏞️"
        )
    ]

    fileprivate static let sportsInterests = [
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
        ),
        InterestModel(
            id: UUID(uuidString: "C136A069-5995-47BF-92C4-419F7C2C8434"),
            name: "Baseball",
            glyph: "⚾️"
        ),
        InterestModel(
            id: UUID(uuidString: "F12548F0-9A8D-446A-9297-EADFD050A28C"),
            name: "Basketball",
            glyph: "🏀"
        ),
        InterestModel(
            id: UUID(uuidString: "196B23D9-B8B9-4333-B4F2-9B0D30D8B4C5"),
            name: "Bodybuilding",
            glyph: "🏋️‍♀️"
        ),
        InterestModel(
            id: UUID(uuidString: "751990E1-9734-4303-A4B0-5CA049592304"),
            name: "Bouldering",
            glyph: "🧗"
        ),
        InterestModel(
            id: UUID(uuidString: "A9C12AD8-988C-44C6-BF57-9BB8F39E6D65"),
            name: "Bowling",
            glyph: "🎳"
        ),
        InterestModel(
            id: UUID(uuidString: "3E66B286-D5F2-4D8A-829F-0C3924BCA43E"),
            name: "Boxing",
            glyph: "🥊"
        ),
        InterestModel(
            id: UUID(uuidString: "0A2C9D14-C4AB-4447-B94D-F0CB0063314A"),
            name: "Cardio",
            glyph: "💓"
        ),
        InterestModel(
            id: UUID(uuidString: "EFEF650C-9E8D-4125-99FA-00E0DB5E3F6F"),
            name: "Chess",
            glyph: "♟️"
        ),
        InterestModel(
            id: UUID(uuidString: "782E6231-8437-4058-B898-2BCC3E88BC41"),
            name: "Circus skills",
            glyph: "🎪"
        ),
        InterestModel(
            id: UUID(uuidString: "477D40A0-2B59-40F8-87C4-11013B148743"),
            name: "Cricket",
            glyph: "🏏"
        ),
        InterestModel(
            id: UUID(uuidString: "CD78740F-7D86-49D1-ADE1-09527EDA4EF4"),
            name: "Cycling",
            glyph: "🚴"
        ),
        InterestModel(
            id: UUID(uuidString: "BBA8EF45-289A-4CCB-9CF1-AE24DF0F5449"),
            name: "Fencing",
            glyph: "🤺"
        ),
        InterestModel(
            id: UUID(uuidString: "291FEFCB-684C-4574-AA41-549514617AA5"),
            name: "Frisbee",
            glyph: "🥏"
        ),
        InterestModel(
            id: UUID(uuidString: "19D8D8E4-359A-4565-B729-CAD838B6707C"),
            name: "Functional fitness",
            glyph: "🙌"
        ),
        InterestModel(
            id: UUID(uuidString: "8B9B6081-34ED-4E53-908E-D13C73C133BE"),
            name: "Go karting",
            glyph: "🏎️"
        ),
        InterestModel(
            id: UUID(uuidString: "DC2D63E2-DE00-4A5C-8CA4-B91A262DEB45"),
            name: "Golf",
            glyph: "🏌️‍♀️"
        ),
        InterestModel(
            id: UUID(uuidString: "24407CA6-700A-40B3-BF6E-85F39F74440D"),
            name: "Gym",
            glyph: "🏋️‍♀️"
        ),
        InterestModel(
            id: UUID(uuidString: "BDFCBAB1-0119-435A-AB72-A0FCC2AE598B"),
            name: "Gymnastics",
            glyph: "🤸"
        ),
        InterestModel(
            id: UUID(uuidString: "D20939EB-180A-4EDF-9D59-B4D94D54ADC9"),
            name: "Handball",
            glyph: "🤾"
        ),
        InterestModel(
            id: UUID(uuidString: "F63ED091-3950-4D1E-A3E4-EE6EDC2B6F63"),
            name: "HIIT",
            glyph: "🥵"
        ),
        InterestModel(
            id: UUID(uuidString: "46DFE605-8194-4CC2-A185-E49AB3AB87CA"),
            name: "Hiking",
            glyph: "🥾"
        ),
        InterestModel(
            id: UUID(uuidString: "2904D977-7CF2-4E2C-A035-270A1DB74314"),
            name: "Hockey",
            glyph: "🏑"
        ),
        InterestModel(
            id: UUID(uuidString: "0CCC0F15-D86C-43F3-B298-9920054EFD19"),
            name: "Horse riding",
            glyph: "🏇"
        ),
        InterestModel(
            id: UUID(uuidString: "BAADED6B-50DF-443B-9437-AFA051F77674"),
            name: "Kayaking",
            glyph: "🚣"
        ),
        InterestModel(
            id: UUID(uuidString: "74DE1A3D-C240-41DD-BE0A-8B402D2ACF57"),
            name: "Lacrosse",
            glyph: "🥍"
        ),
        InterestModel(
            id: UUID(uuidString: "777F2070-436A-4FEA-9639-CEC03E9AA467"),
            name: "Martial arts",
            glyph: "🥋"
        ),
        InterestModel(
            id: UUID(uuidString: "C6F18FC4-1C47-4A93-A3F8-8E6411DCDC17"),
            name: "Meditation",
            glyph: "🧘"
        ),
        InterestModel(
            id: UUID(uuidString: "376EF666-3A82-4AB9-88DD-68FBF2262229"),
            name: "Motorbiking",
            glyph: "🏍️"
        ),
        InterestModel(
            id: UUID(uuidString: "DDC63144-9E03-4418-83D9-ED405DF97834"),
            name: "Motorsports",
            glyph: "🏁"
        ),
        InterestModel(
            id: UUID(uuidString: "6BAAF901-149E-429D-8061-389140FF94A3"),
            name: "Netball",
            glyph: "🏐"
        ),
        InterestModel(
            id: UUID(uuidString: "3B459979-B0B8-4A8D-9331-B129926DDCFD"),
            name: "Padel",
            glyph: "🏓"
        ),
        InterestModel(
            id: UUID(uuidString: "AEC62E4D-C5B0-4EE8-BC15-54AF83E2A643"),
            name: "Parkour",
            glyph: "🤸"
        ),
        InterestModel(
            id: UUID(uuidString: "5F7D504B-1175-44EC-9F16-829C55B72EF1"),
            name: "Pickleball",
            glyph: "🏓"
        ),
        InterestModel(
            id: UUID(uuidString: "46D94C84-CAFD-420E-84DE-F0B5686CAB2E"),
            name: "Pilates",
            glyph: "🤸‍♀️"
        ),
        InterestModel(
            id: UUID(uuidString: "25F56EFB-6E2D-4B18-8C27-F13A3E38E88F"),
            name: "Powerlifting",
            glyph: "🥇"
        ),
        InterestModel(
            id: UUID(uuidString: "F554E30F-17B6-4F1A-8E15-5A0EA23CA3BB"),
            name: "Roller skating",
            glyph: "🛼"
        ),
        InterestModel(
            id: UUID(uuidString: "ACAAE308-8EA2-4E03-9CA3-DC5A3A057F71"),
            name: "Rowing",
            glyph: "🚣"
        ),
        InterestModel(
            id: UUID(uuidString: "0E8B124F-E90F-4F45-B3EC-3273EC857F88"),
            name: "Rugby",
            glyph: "🏉"
        ),
        InterestModel(
            id: UUID(uuidString: "170EA87D-05D4-4483-A22D-9F32FD46BBB1"),
            name: "Run clubs",
            glyph: "🏃‍♂️"
        ),
        InterestModel(
            id: UUID(uuidString: "30EB926D-A30C-4ECF-859E-328942C5ACA1"),
            name: "Running",
            glyph: "🏃"
        ),
        InterestModel(
            id: UUID(uuidString: "A123FB8B-DB5B-4B3F-B190-347AA223F061"),
            name: "Sailing",
            glyph: "⛵️"
        ),
        InterestModel(
            id: UUID(uuidString: "E69D0E29-B27A-40A2-BD1F-1BB14076E4D5"),
            name: "Scuba diving",
            glyph: "🤿"
        ),
        InterestModel(
            id: UUID(uuidString: "B4664E46-FA18-4B02-BB3A-BBC4E7380B86"),
            name: "Skateboarding",
            glyph: "🛹"
        ),
        InterestModel(
            id: UUID(uuidString: "B1CBFFA6-3AD8-408A-A83E-574E97228C87"),
            name: "Skiing",
            glyph: "⛷️"
        ),
        InterestModel(
            id: UUID(uuidString: "A68A1E37-565C-4291-B5D7-379D3809135F"),
            name: "Snowboarding",
            glyph: "🏂"
        ),
        InterestModel(
            id: UUID(uuidString: "EE7E61A8-D3E9-45D4-AF94-E1885A54BAED"),
            name: "Softball",
            glyph: "🥎"
        ),
        InterestModel(
            id: UUID(uuidString: "948CB1DC-F089-4653-851F-35705EFD8509"),
            name: "Squash",
            glyph: "🏓"
        ),
        InterestModel(
            id: UUID(uuidString: "A2E659B4-03F1-4CFA-9E8C-C529DFF6B942"),
            name: "Surfing",
            glyph: "🏄"
        ),
        InterestModel(
            id: UUID(uuidString: "28AE46F5-0369-49E4-93E0-2E9D53F0D340"),
            name: "Swimming",
            glyph: "🏊"
        ),
        InterestModel(
            id: UUID(uuidString: "2756C429-0444-4ACC-8A47-12BE5010CCCD"),
            name: "Table tennis",
            glyph: "🏓"
        ),
        InterestModel(
            id: UUID(uuidString: "AD3FCFF0-EE7C-4CE1-8B86-4BF491CA1CDC"),
            name: "Tennis",
            glyph: "🎾"
        ),
        InterestModel(
            id: UUID(uuidString: "4651CA19-EC3C-423F-AF81-668255A835E2"),
            name: "Volleyball",
            glyph: "🏐"
        ),
        InterestModel(
            id: UUID(uuidString: "B5796602-97D0-4F0E-AC10-18D5FB90AEEC"),
            name: "Weightlifting",
            glyph: "🏋️‍♂️"
        )
    ]

    fileprivate static let creativityInterests = [
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
            id: UUID(uuidString: "50C77557-7344-4CB7-A52F-7CE703CE31B2"),
            name: "Crocheting",
            glyph: "🧶"
        ),
        InterestModel(
            id: UUID(uuidString: "CE73EA1F-F795-4242-852C-0AB85DE8765C"),
            name: "Dancing",
            glyph: "💃"
        ),
        InterestModel(
            id: UUID(uuidString: "AE7C71EE-8333-4E02-BBB6-3232AE8035E5"),
            name: "Design",
            glyph: "✏️"
        ),
        InterestModel(
            id: UUID(uuidString: "6CB36664-5C1B-4E3F-AFD5-637EEFE554D3"),
            name: "Drawing",
            glyph: "✏️"
        ),
        InterestModel(
            id: UUID(uuidString: "B5FC8C12-E320-4A5B-B680-A2D4002A044A"),
            name: "Fashion",
            glyph: "👗"
        ),
        InterestModel(
            id: UUID(uuidString: "549DEA1A-2D46-4363-B6F0-A3EE8EA85A22"),
            name: "Knitting",
            glyph: "🧶"
        ),
        InterestModel(
            id: UUID(uuidString: "8C2058DB-212D-44F4-AEA8-B986367F5B99"),
            name: "Make-up",
            glyph: "💄"
        ),
        InterestModel(
            id: UUID(uuidString: "99F89903-1591-428D-8077-5D48FCAFFB91"),
            name: "Making videos",
            glyph: "📼"
        ),
        InterestModel(
            id: UUID(uuidString: "43740B0B-0D29-415E-B313-C0F9557BFD55"),
            name: "Memes",
            glyph: "🤣"
        ),
        InterestModel(
            id: UUID(uuidString: "08464419-E1FB-4863-BB4D-CCE8347EE6D0"),
            name: "Nail art",
            glyph: "💅"
        ),
        InterestModel(
            id: UUID(uuidString: "7640607F-B310-4E60-8B12-1FB7E680022B"),
            name: "Painting",
            glyph: "🎨"
        ),
        InterestModel(
            id: UUID(uuidString: "0A2A1A61-C9D4-49D7-BAC6-9F037C289A20"),
            name: "Photography",
            glyph: "📸"
        ),
        InterestModel(
            id: UUID(uuidString: "FB02635A-0F98-401C-AF1B-D9AD93A1E277"),
            name: "Pottery",
            glyph: "🏺"
        ),
        InterestModel(
            id: UUID(uuidString: "95E9D89B-A55D-4303-B379-8F17F0B2E5CB"),
            name: "Singing",
            glyph: "🎤"
        ),
        InterestModel(
            id: UUID(uuidString: "63781F30-3A36-419B-A299-900022112289"),
            name: "Thrifting",
            glyph: "🛍️"
        ),
        InterestModel(
            id: UUID(uuidString: "6A68253A-4508-421C-AC74-1149C4FDC343"),
            name: "Upcycling",
            glyph: "🪑"
        ),
        InterestModel(
            id: UUID(uuidString: "62B25885-E09B-4CFB-A91D-0728F2CFEFA9"),
            name: "Writing",
            glyph: "📝"
        )
    ]

    fileprivate static let goingOutInterests = [
        InterestModel(
            id: UUID(uuidString: "E9177441-8725-4962-9895-6BF84BF652A2"),
            name: "Cafe-hopping",
            glyph: "☕️"
        ),
        InterestModel(
            id: UUID(uuidString: "25A6FEB0-FCC9-405B-A75D-90AE0A0E3908"),
            name: "Films",
            glyph: "🍿"
        ),
        InterestModel(
            id: UUID(uuidString: "82BE11E7-C54A-42DE-9BBA-5A76A4EFBFDF"),
            name: "Gigs",
            glyph: "🎟️"
        ),
        InterestModel(
            id: UUID(uuidString: "D8D0A4CE-B7AD-484F-9609-D02D43B84E4B"),
            name: "LGBTQ+ nightlife",
            glyph: "🎉"
        ),
        InterestModel(
            id: UUID(uuidString: "6BC49DDE-362C-4428-8C38-D02967386345"),
            name: "Nightclubs",
            glyph: "🕺"
        ),
        InterestModel(
            id: UUID(uuidString: "8C545453-55E6-4E6D-BFF8-FE2BDFB4DF73"),
            name: "Stand up",
            glyph: "🎙️"
        ),
        InterestModel(
            id: UUID(uuidString: "4CE5A678-F507-471C-A502-6F0EFF2B48EF"),
            name: "Trivia",
            glyph: "❓"
        ),
        InterestModel(
            id: UUID(uuidString: "A8CA2E6F-7419-4CBC-8D7F-F63820E76BBC"),
            name: "Drag shows",
            glyph: "👑"
        ),
        InterestModel(
            id: UUID(uuidString: "9483DAA1-005E-4D2C-AC2B-6FE5F2AD151F"),
            name: "Festivals",
            glyph: "🎊"
        ),
        InterestModel(
            id: UUID(uuidString: "1588342F-7605-45F3-8779-F32AD0F5BFA1"),
            name: "Improv",
            glyph: "🎭"
        ),
        InterestModel(
            id: UUID(uuidString: "C69F5B25-DE3F-4016-9C31-E05341ED6EEB"),
            name: "Karaoke",
            glyph: "🎤"
        ),
        InterestModel(
            id: UUID(uuidString: "618D19D0-690B-4FEC-88EE-1267F3C33F1F"),
            name: "Museums & galleries",
            glyph: "🏛️"
        ),
        InterestModel(
            id: UUID(uuidString: "A41E5DF8-D2C2-4686-B4A0-A695A3A26235"),
            name: "Salsa dancing",
            glyph: "💃"
        ),
        InterestModel(
            id: UUID(uuidString: "3E97F032-3261-4837-93B1-7B684EB4756F"),
            name: "Trainspotting",
            glyph: "🚂"
        ),
        InterestModel(
            id: UUID(uuidString: "430E131F-4D6E-4586-ABB5-00427A46B636"),
            name: "Pubs",
            glyph: "🍻"
        ),
        InterestModel(
            id: UUID(uuidString: "4357044A-8CCD-4C14-A5A3-B732ACB24729"),
            name: "Theatre",
            glyph: "🎭"
        ),
        InterestModel(
            id: UUID(uuidString: "9F323D82-6341-40E9-A421-2988ADD8B5D0"),
            name: "Wine tasting",
            glyph: "🍷"
        )
    ]

    fileprivate static let stayingInInterests = [
        InterestModel(
            id: UUID(uuidString: "E6F2254D-766E-4F6F-8383-AC85B97B5FCA"),
            name: "AI",
            glyph: "🤖"
        ),
        InterestModel(
            id: UUID(uuidString: "34C9A117-DE1F-4B68-BCCC-49C815E4A9AA"),
            name: "Cooking",
            glyph: "🧑‍🍳"
        ),
        InterestModel(
            id: UUID(uuidString: "68C03584-E403-4077-8011-1D55FB36E486"),
            name: "Podcasts",
            glyph: "🎙️"
        ),
        InterestModel(
            id: UUID(uuidString: "E1CE18E6-925A-4443-88F0-51B84231880A"),
            name: "Baking",
            glyph: "🍰"
        ),
        InterestModel(
            id: UUID(uuidString: "52CF1837-7919-4D67-B9DD-F6472DA64AF2"),
            name: "Board games",
            glyph: "🎲"
        ),
        InterestModel(
            id: UUID(uuidString: "35927D87-9821-4EE0-B3F0-DF5D14112ACB"),
            name: "Gardening",
            glyph: "🧑‍🌾"
        ),
        InterestModel(
            id: UUID(uuidString: "DD6D65A7-8031-4259-9B74-B06DF3EF049D"),
            name: "Programming",
            glyph: "🖥️"
        ),
        InterestModel(
            id: UUID(uuidString: "DF45E7BA-1DAE-49F9-847E-EC9E66C81C97"),
            name: "Chess",
            glyph: "♟️"
        ),
        InterestModel(
            id: UUID(uuidString: "F9917FAC-6957-4910-A4FB-7D9FF2542033"),
            name: "House plants",
            glyph: "🪴"
        ),
        InterestModel(
            id: UUID(uuidString: "9BF585EC-3E77-4444-860D-7DE123C4CA03"),
            name: "Reading",
            glyph: "📕"
        )
    ]

    fileprivate static let filmAndTVInterests = [
        InterestModel(
            id: UUID(uuidString: "54B43AE5-BAB6-48D5-B45E-1A33DD7AE26B"),
            name: "Action & adventure",
            glyph: "📺"
        ),
        InterestModel(
            id: UUID(uuidString: "184475BE-A58F-40B4-AA3A-B35C18ED9D9C"),
            name: "Comedy",
            glyph: "📺"
        ),
        InterestModel(
            id: UUID(uuidString: "CB93F7B7-B2F3-4C8F-BA3D-7980D624558E"),
            name: "Horror",
            glyph: "📺"
        ),
        InterestModel(
            id: UUID(uuidString: "05E0771A-8B11-47E4-A722-154C61F52AE3"),
            name: "Thriller",
            glyph: "📺"
        ),
        InterestModel(
            id: UUID(uuidString: "D3CCC238-19A8-45F7-A572-0B68BABC3E74"),
            name: "Animated",
            glyph: "📺"
        ),
        InterestModel(
            id: UUID(uuidString: "0BD71D56-B493-4210-8A93-7888C0DB5B25"),
            name: "Anime",
            glyph: "📺"
        ),
        InterestModel(
            id: UUID(uuidString: "AF3E67B7-C970-49D8-BE0D-3E15F5E487DF"),
            name: "Bollywood",
            glyph: "📺"
        ),
        InterestModel(
            id: UUID(uuidString: "13998945-72A2-48F7-BB39-672E1DFAC28D"),
            name: "Cooking shows",
            glyph: "📺"
        ),
        InterestModel(
            id: UUID(uuidString: "3F4EC7BE-AF39-4DB7-8676-321505E63D4D"),
            name: "Crime",
            glyph: "📺"
        ),
        InterestModel(
            id: UUID(uuidString: "07EB2412-FD17-4CE5-B1BF-62483A939FE5"),
            name: "Documentaries",
            glyph: "📺"
        ),
        InterestModel(
            id: UUID(uuidString: "F95C7787-ECBA-4D5D-9AFA-C06FB96F9DA2"),
            name: "Drama",
            glyph: "📺"
        ),
        InterestModel(
            id: UUID(uuidString: "B464B2AC-F74B-499D-A2CB-5A70914D0CFC"),
            name: "Fantasy",
            glyph: "📺"
        ),
        InterestModel(
            id: UUID(uuidString: "737A15DC-8AFD-420D-8B54-EF747D1A398B"),
            name: "Game shows",
            glyph: "📺"
        ),
        InterestModel(
            id: UUID(uuidString: "DDE6AD20-C0EE-4335-A00F-8FBBA87C60B7"),
            name: "Indie",
            glyph: "📺"
        ),
        InterestModel(
            id: UUID(uuidString: "B4E7290D-DE82-47EC-A046-AEC7AC85EDF7"),
            name: "K-drama",
            glyph: "📺"
        ),
        InterestModel(
            id: UUID(uuidString: "68E052BB-B1B7-4E3C-8B19-CFD3B4D36428"),
            name: "Mystery",
            glyph: "📺"
        ),
        InterestModel(
            id: UUID(uuidString: "4FBD5386-6022-47D9-9FBE-30283F4E3CD7"),
            name: "Reality shows",
            glyph: "📺"
        ),
        InterestModel(
            id: UUID(uuidString: "82A8E4EA-523C-43C4-B83F-66D3F74C14E8"),
            name: "Rom-com",
            glyph: "📺"
        ),
        InterestModel(
            id: UUID(uuidString: "852E4F5C-7724-40FB-8C2B-B51D79E61733"),
            name: "Romance",
            glyph: "📺"
        ),
        InterestModel(
            id: UUID(uuidString: "9100706B-7C89-4746-905C-FD4232A6A5D7"),
            name: "Sci-fi",
            glyph: "📺"
        ),
        InterestModel(
            id: UUID(uuidString: "B8E910B4-7F17-44BF-B51C-1CDFB1062119"),
            name: "Superhero",
            glyph: "📺"
        )
    ]

    fileprivate static let readingInterests = [
        InterestModel(
            id: UUID(uuidString: "0973FE28-4594-4987-8326-57E2AE739D37"),
            name: "Action & adventure",
            glyph: "📚"
        ),
        InterestModel(
            id: UUID(uuidString: "15CE75A7-A8FC-479F-8DC8-0465C5A645A4"),
            name: "Biographies",
            glyph: "📚"
        ),
        InterestModel(
            id: UUID(uuidString: "671EB802-3FDB-488F-A4BA-88A18A4F1BB9"),
            name: "Classics",
            glyph: "📚"
        ),
        InterestModel(
            id: UUID(uuidString: "3D235A28-9E5C-4CBC-8E9C-F8E1FABB0906"),
            name: "Comedy",
            glyph: "📚"
        ),
        InterestModel(
            id: UUID(uuidString: "4091DA9E-F818-4CAD-BA1D-0BE4415936E6"),
            name: "Comic books",
            glyph: "📚"
        ),
        InterestModel(
            id: UUID(uuidString: "8CE3A2A5-8BA7-4068-B29D-D840E32F98DF"),
            name: "Crime",
            glyph: "📚"
        ),
        InterestModel(
            id: UUID(uuidString: "44AC119F-C299-409D-A14E-4125D58961E8"),
            name: "Fantasy",
            glyph: "📚"
        ),
        InterestModel(
            id: UUID(uuidString: "D8ABB0A8-9B43-4478-8BE1-FA0EBE811538"),
            name: "History",
            glyph: "📚"
        ),
        InterestModel(
            id: UUID(uuidString: "9140DDAD-82F4-4C26-83A1-9CC059BD33C1"),
            name: "Horror",
            glyph: "📚"
        ),
        InterestModel(
            id: UUID(uuidString: "2B7A84CD-FDEC-4D5A-8DBF-A5A247D08E28"),
            name: "Manga",
            glyph: "📚"
        ),
        InterestModel(
            id: UUID(uuidString: "A637E592-11E9-468B-80B8-CC73312D53B6"),
            name: "Mystery",
            glyph: "📚"
        ),
        InterestModel(
            id: UUID(uuidString: "259E3402-5CD0-4949-A836-A591390656ED"),
            name: "Philosophy",
            glyph: "📚"
        ),
        InterestModel(
            id: UUID(uuidString: "12BAB00A-7D17-4828-95FE-A80837175F61"),
            name: "Poetry",
            glyph: "📚"
        ),
        InterestModel(
            id: UUID(uuidString: "F068719F-E9B9-470D-9183-178A24C34A42"),
            name: "Psychology",
            glyph: "📚"
        ),
        InterestModel(
            id: UUID(uuidString: "6224C2DE-FFDB-4213-959B-B646EC4C6B67"),
            name: "Romance",
            glyph: "📚"
        ),
        InterestModel(
            id: UUID(uuidString: "8FC4060A-CBF2-4591-AFB7-402ECA958B11"),
            name: "Sci-fi",
            glyph: "📚"
        ),
        InterestModel(
            id: UUID(uuidString: "699AFDA8-2088-4C99-B751-73FB1CEFFC7D"),
            name: "Science",
            glyph: "📚"
        )
    ]

    fileprivate static let musicInterests = [
        InterestModel(
            id: UUID(uuidString: "2C841A20-2D9B-4A5C-90CF-4362826BED83"),
            name: "Afro",
            glyph: "🎵"
        ),
        InterestModel(
            id: UUID(uuidString: "B52939FB-884C-4F6E-AAB0-0C5814F0699D"),
            name: "Arab",
            glyph: "🎵"
        ),
        InterestModel(
            id: UUID(uuidString: "29AF55B0-1169-40F6-82EE-A304C6CDB40A"),
            name: "Blues",
            glyph: "🎵"
        ),
        InterestModel(
            id: UUID(uuidString: "94B90893-A96D-443C-8FB5-730EEB0088AC"),
            name: "Classical",
            glyph: "🎵"
        ),
        InterestModel(
            id: UUID(uuidString: "517E0BB7-C9B1-420B-B019-FCAFA821D893"),
            name: "Country",
            glyph: "🎵"
        ),
        InterestModel(
            id: UUID(uuidString: "6D6D26B9-7767-494A-A1DC-989BA6345320"),
            name: "Desi",
            glyph: "🎵"
        ),
        InterestModel(
            id: UUID(uuidString: "7C4CB8B0-34C7-4A63-A745-807553DEECF7"),
            name: "EDM",
            glyph: "🎵"
        ),
        InterestModel(
            id: UUID(uuidString: "95D87C9C-F560-44CB-BFDE-5A71EB151A08"),
            name: "Electronic",
            glyph: "🎵"
        ),
        InterestModel(
            id: UUID(uuidString: "CB8876E7-1F94-4DB1-A255-14EDDDC8C945"),
            name: "Folk & acoustic",
            glyph: "🎵"
        ),
        InterestModel(
            id: UUID(uuidString: "5FFCB520-DDBD-4555-A9A9-591AA29716B1"),
            name: "Funk",
            glyph: "🎵"
        ),
        InterestModel(
            id: UUID(uuidString: "BDD5D7B6-9D09-4F4D-981D-B9324D49C875"),
            name: "Gothic",
            glyph: "🎵"
        ),
        InterestModel(
            id: UUID(uuidString: "2257DB37-B3AC-41D9-9608-ADE09EF7E096"),
            name: "Hip hop",
            glyph: "🎵"
        ),
        InterestModel(
            id: UUID(uuidString: "6B0C4D41-588F-48C2-BD4D-73C9E90335D4"),
            name: "House",
            glyph: "🎵"
        ),
        InterestModel(
            id: UUID(uuidString: "AF960ED5-6346-4200-B518-0074F1C5FC06"),
            name: "Indie",
            glyph: "🎵"
        ),
        InterestModel(
            id: UUID(uuidString: "AB9EB711-E051-402A-B381-FB486C50D0E6"),
            name: "Jazz",
            glyph: "🎵"
        ),
        InterestModel(
            id: UUID(uuidString: "FA345493-0CDF-42B4-9580-130CB64E02FF"),
            name: "K-pop",
            glyph: "🎵"
        ),
        InterestModel(
            id: UUID(uuidString: "6D8AD40D-A918-4015-A622-60C616B56C8D"),
            name: "Latin",
            glyph: "🎵"
        ),
        InterestModel(
            id: UUID(uuidString: "02744BE2-4FA4-49C5-B18A-E71014ACF99A"),
            name: "Metal",
            glyph: "🎵"
        ),
        InterestModel(
            id: UUID(uuidString: "B84499D5-0A5A-4F6A-BD32-D55795442E82"),
            name: "Pop",
            glyph: "🎵"
        ),
        InterestModel(
            id: UUID(uuidString: "6E3BAA05-6641-421E-832F-10505E3267BC"),
            name: "Punk",
            glyph: "🎵"
        ),
        InterestModel(
            id: UUID(uuidString: "08A0982D-E2F5-49B4-9D18-F131ECEC4933"),
            name: "R&B",
            glyph: "🎵"
        ),
        InterestModel(
            id: UUID(uuidString: "6F96CB7B-F41A-4C18-BFEE-7BE8DD72AB19"),
            name: "Rap",
            glyph: "🎵"
        ),
        InterestModel(
            id: UUID(uuidString: "12786A4A-DB8B-494B-8453-7DF05CE3CD64"),
            name: "Reggae",
            glyph: "🎵"
        ),
        InterestModel(
            id: UUID(uuidString: "5C10A236-1BE8-4503-BEB6-3466851BA95D"),
            name: "Rock",
            glyph: "🎵"
        ),
        InterestModel(
            id: UUID(uuidString: "B6F639C4-0819-4403-A325-1011DCF4B493"),
            name: "Soul",
            glyph: "🎵"
        ),
        InterestModel(
            id: UUID(uuidString: "EEA1BBB4-4B60-4608-8EA9-CDDBC54C9E7B"),
            name: "Techno",
            glyph: "🎵"
        )
    ]

    fileprivate static let foodAndDrinkInterests = [
        InterestModel(
            id: UUID(uuidString: "313FEF8B-8A2D-4DCC-9F4A-6D214A7A0BBA"),
            name: "Coffee",
            glyph: "☕️"
        ),
        InterestModel(
            id: UUID(uuidString: "24D50243-DB43-4BE5-A691-F2BCB654A3A7"),
            name: "BBQ",
            glyph: "🥩"
        ),
        InterestModel(
            id: UUID(uuidString: "2682A14D-8D34-43ED-8284-84D9C31E761E"),
            name: "Beer",
            glyph: "🍺"
        ),
        InterestModel(
            id: UUID(uuidString: "B1087895-1876-494D-AE29-7E5B9493557D"),
            name: "Biryani",
            glyph: "🍛"
        ),
        InterestModel(
            id: UUID(uuidString: "7965B404-AA04-4878-B00B-C47E66640B50"),
            name: "Bubble tea",
            glyph: "🧋"
        ),
        InterestModel(
            id: UUID(uuidString: "26E672A8-BF34-4E7A-8F55-37AF2C409CE5"),
            name: "Burgers",
            glyph: "🍔"
        ),
        InterestModel(
            id: UUID(uuidString: "743EAB5A-A4B1-43AD-BDC4-00BD5A9474F7"),
            name: "Cake",
            glyph: "🧁"
        ),
        InterestModel(
            id: UUID(uuidString: "43C7C542-0937-44AF-969F-64CF32D4C956"),
            name: "Cocktails",
            glyph: "🍹"
        ),
        InterestModel(
            id: UUID(uuidString: "BB0B3FAD-76F9-4AE3-8743-368F985E21EA"),
            name: "Fish & chips",
            glyph: "🐟"
        ),
        InterestModel(
            id: UUID(uuidString: "6B554887-5933-4B35-A330-8A7F85B72EED"),
            name: "Foodie",
            glyph: "🍜"
        ),
        InterestModel(
            id: UUID(uuidString: "EB12A9F2-09C0-4A17-81D6-A18F4CBE1BB6"),
            name: "Gin",
            glyph: "🍸"
        ),
        InterestModel(
            id: UUID(uuidString: "BC508B59-1098-49CA-974E-A797935941C2"),
            name: "Kimchi",
            glyph: "🥬"
        ),
        InterestModel(
            id: UUID(uuidString: "FF215054-812F-4D76-A462-3BE5B99D737C"),
            name: "Mocktails",
            glyph: "🍹"
        ),
        InterestModel(
            id: UUID(uuidString: "C710A523-D9B6-4676-8E35-E08081D52256"),
            name: "Pizza",
            glyph: "🍕"
        ),
        InterestModel(
            id: UUID(uuidString: "398C94CA-780E-4FBB-B741-9934680AB0E9"),
            name: "Plant-based",
            glyph: "🥑"
        ),
        InterestModel(
            id: UUID(uuidString: "2C87ED9D-2939-4676-8C7A-85E76C98AEFA"),
            name: "Smoothies",
            glyph: "🍌"
        ),
        InterestModel(
            id: UUID(uuidString: "D63D2404-14EF-4C75-9C8E-93A86EFB02D7"),
            name: "Sunday roast",
            glyph: "🍗"
        ),
        InterestModel(
            id: UUID(uuidString: "F676BF34-9117-448E-AB38-560CD7E26D4D"),
            name: "Sushi",
            glyph: "🍣"
        ),
        InterestModel(
            id: UUID(uuidString: "5E1A0CFC-9147-4C8E-95AA-3BC74F0A7785"),
            name: "Sweet tooth",
            glyph: "🍫"
        ),
        InterestModel(
            id: UUID(uuidString: "E26FC09F-4D91-40B1-95D7-EEC46144D2BE"),
            name: "Tacos",
            glyph: "🌮"
        ),
        InterestModel(
            id: UUID(uuidString: "F06ED215-37C1-4DFC-8985-849D1FF6CEF7"),
            name: "Takeaways",
            glyph: "🥡"
        ),
        InterestModel(
            id: UUID(uuidString: "8E2F0164-CB96-4052-9592-8D58282192AC"),
            name: "Tea",
            glyph: "🫖"
        ),
        InterestModel(
            id: UUID(uuidString: "9A24F4C5-CDBC-497A-B4AA-4AF506152A55"),
            name: "Vegan",
            glyph: "🌱"
        ),
        InterestModel(
            id: UUID(uuidString: "81D87A78-682B-4C53-A1D0-C0A6BA07D63F"),
            name: "Vegetarian",
            glyph: "🥦"
        ),
        InterestModel(
            id: UUID(uuidString: "140DB084-E6BD-4045-B400-11BE9C187E17"),
            name: "Whisky",
            glyph: "🥃"
        ),
        InterestModel(
            id: UUID(uuidString: "9DCC1777-826B-456E-8B26-515D881A3F0A"),
            name: "Wine",
            glyph: "🍷"
        )
    ]

    fileprivate static let travellingInterests = [
        InterestModel(
            id: UUID(uuidString: "CDE1FADD-E58E-49EF-8BBF-B6B1A8578F54"),
            name: "Backpacking",
            glyph: "🎒"
        ),
        InterestModel(
            id: UUID(uuidString: "0C4BE9DD-E678-4F6B-8461-6DE71E4A1235"),
            name: "City breaks",
            glyph: "🌆"
        ),
        InterestModel(
            id: UUID(uuidString: "05DD94A4-07A1-4E6D-BFD5-5F202726EBE6"),
            name: "Fishing trips",
            glyph: "🎣"
        ),
        InterestModel(
            id: UUID(uuidString: "9A1FFD57-B1BB-43DD-858A-35F9E66E4C69"),
            name: "Solo trips",
            glyph: "🧳"
        ),
        InterestModel(
            id: UUID(uuidString: "4B792A39-B351-4B9C-A5EA-A81CB71E318F"),
            name: "Beaches",
            glyph: "🏖️"
        ),
        InterestModel(
            id: UUID(uuidString: "26A0A93D-75DC-4148-AC4A-C3D7E8C18026"),
            name: "Camping",
            glyph: "🏕️"
        ),
        InterestModel(
            id: UUID(uuidString: "3628BF4F-280F-4F8C-8D80-7C54879D842C"),
            name: "Country escapes",
            glyph: "🏡"
        ),
        InterestModel(
            id: UUID(uuidString: "C8E470D5-C79C-4B0D-B63E-90394BC3A4F5"),
            name: "Hiking trips",
            glyph: "🗻"
        ),
        InterestModel(
            id: UUID(uuidString: "786859EA-DAB9-4FEA-8C5C-539FAC805E02"),
            name: "Spa weekends",
            glyph: "🛀"
        ),
        InterestModel(
            id: UUID(uuidString: "48DB9BCB-DA8D-4922-AD3B-35B7B5D11A01"),
            name: "Road trips",
            glyph: "🚗"
        ),
        InterestModel(
            id: UUID(uuidString: "E63AEA96-DB38-44A5-8846-F046DA6CF015"),
            name: "Winter trips",
            glyph: "❄️"
        )
    ]

    fileprivate static let petsInterests = [
        InterestModel(
            id: UUID(uuidString: "D8C71F78-19E0-4F64-BC11-3D27FCF16F88"),
            name: "Beekeeping",
            glyph: "🐝"
        ),
        InterestModel(
            id: UUID(uuidString: "9911AC3F-9046-479A-A33B-B4BFB5F96D9E"),
            name: "Birds",
            glyph: "🐦"
        ),
        InterestModel(
            id: UUID(uuidString: "5D440FDC-6A36-41DF-9667-D61700EA32E0"),
            name: "Fish",
            glyph: "🐠"
        ),
        InterestModel(
            id: UUID(uuidString: "F646662A-C8A6-4D01-9EA1-01F270CE5BA6"),
            name: "Lizards",
            glyph: "🦎"
        ),
        InterestModel(
            id: UUID(uuidString: "65BEE805-021C-4CC4-A8FC-83975D8F22EA"),
            name: "Turtles",
            glyph: "🐢"
        ),
        InterestModel(
            id: UUID(uuidString: "16133318-6602-4352-AA47-FBDE50FCB823"),
            name: "Cats",
            glyph: "🐈"
        ),
        InterestModel(
            id: UUID(uuidString: "07B1F4BB-98EE-4AB4-9EA7-7E92E6D5D63A"),
            name: "Rabbits",
            glyph: "🐇"
        ),
        InterestModel(
            id: UUID(uuidString: "81FCB16E-2ADB-483E-B976-C8F96EE61335"),
            name: "Dogs",
            glyph: "🐕"
        ),
        InterestModel(
            id: UUID(uuidString: "D9198721-87F9-4E67-8FC0-8982482E0E22"),
            name: "Snakes",
            glyph: "🐍"
        )
    ]

    fileprivate static let personalityAndTraitsInterests = [
        InterestModel(
            id: UUID(uuidString: "39156D1E-1D14-43E0-BFBA-60D665EADCE5"),
            name: "Ambition",
            glyph: "🚀"
        ),
        InterestModel(
            id: UUID(uuidString: "AF540C5E-4E14-414E-9238-DF44DF928E2E"),
            name: "Being active",
            glyph: "🏆"
        ),
        InterestModel(
            id: UUID(uuidString: "2F1AE3BA-9135-4657-AB8E-F6F0CD2590C4"),
            name: "Being family-oriented",
            glyph: "❤️"
        ),
        InterestModel(
            id: UUID(uuidString: "F83E9FBD-64BC-4F00-9D71-497059BBDC1E"),
            name: "Being romantic",
            glyph: "💖"
        ),
        InterestModel(
            id: UUID(uuidString: "A65E02F1-E18A-4A03-9398-8E3CE6491EC3"),
            name: "Empathy",
            glyph: "💚"
        ),
        InterestModel(
            id: UUID(uuidString: "11BD77DB-7B2F-496F-BF12-438D84652E7A"),
            name: "Self-awareness",
            glyph: "🧐"
        ),
        InterestModel(
            id: UUID(uuidString: "EDAF6A7C-E283-40D9-9349-03E02C96FB02"),
            name: "Intelligence",
            glyph: "🎓"
        ),
        InterestModel(
            id: UUID(uuidString: "B02A72D2-7DCC-45E7-9A40-F84C04252117"),
            name: "Being open-minded",
            glyph: "🧠"
        ),
        InterestModel(
            id: UUID(uuidString: "1640407B-C3EC-4359-A4EF-1DE79AB000F2"),
            name: "Confidence",
            glyph: "😎"
        ),
        InterestModel(
            id: UUID(uuidString: "63F56F32-7B88-4452-983D-6C6EC1C90FAB"),
            name: "Creativity",
            glyph: "🖋️"
        ),
        InterestModel(
            id: UUID(uuidString: "172C0101-5300-42A8-B6FD-9E78FBB70D35"),
            name: "Positivity",
            glyph: ""
        ),
        InterestModel(
            id: UUID(uuidString: "73E737E2-C5F2-435A-9AA3-96CE1BB81BC9"),
            name: "Sense of adventure",
            glyph: "🗻"
        ),
        InterestModel(
            id: UUID(uuidString: "3BE460DF-687A-49AC-8F8D-31371AE5D33C"),
            name: "Sense of humour",
            glyph: "😂"
        ),
        InterestModel(
            id: UUID(uuidString: "9549DC5C-3D93-45D5-8B0D-B7FF9AB860F6"),
            name: "Social awareness",
            glyph: "👁️"
        )
    ]

    fileprivate static let valuesAndAllyshipInterests = [
        InterestModel(
            id: UUID(uuidString: "4193603F-45FC-4E4D-93AC-25C1294AD5F4"),
            name: "Black Lives Matter",
            glyph: "🖤"
        ),
        InterestModel(
            id: UUID(uuidString: "C5960AFE-F057-4977-9A42-1F2D8D93E153"),
            name: "End religious hate",
            glyph: "🚫"
        ),
        InterestModel(
            id: UUID(uuidString: "7B717719-C55A-463C-BD0D-EB78061EDC8C"),
            name: "Environmentalism",
            glyph: "🌍"
        ),
        InterestModel(
            id: UUID(uuidString: "82A98C43-99FE-4504-A581-7FB66CFFBBA8"),
            name: "Feminism",
            glyph: "💛"
        ),
        InterestModel(
            id: UUID(uuidString: "6D4DC314-624D-45E6-B6A0-F28009AB2789"),
            name: "Human rights",
            glyph: "📜"
        ),
        InterestModel(
            id: UUID(uuidString: "54CFA2DE-66AE-4926-9A42-9BF64D73EF70"),
            name: "LGBTQ+ rights",
            glyph: "🏳️‍🌈"
        ),
        InterestModel(
            id: UUID(uuidString: "74D2CC91-2E6D-4625-BC65-F184F2A3A69C"),
            name: "Sex positivity",
            glyph: "➕"
        ),
        InterestModel(
            id: UUID(uuidString: "C83A2BA6-BEB7-48AA-AFA3-B4EA2D68FCC5"),
            name: "Stop Asian Hate",
            glyph: "🚫"
        ),
        InterestModel(
            id: UUID(uuidString: "F04B9A4E-B851-4D15-BD6E-317CFDC3F368"),
            name: "Trans rights",
            glyph: "⚧️"
        ),
        InterestModel(
            id: UUID(uuidString: "1EF020C3-A083-4831-B5EC-A4E7F19C4C58"),
            name: "Volunteering",
            glyph: "🙋"
        ),
        InterestModel(
            id: UUID(uuidString: "A4B1E6FC-B70D-4F77-A33B-D4A27CB1D91E"),
            name: "Voter rights",
            glyph: "☑️"
        )
    ]

}
