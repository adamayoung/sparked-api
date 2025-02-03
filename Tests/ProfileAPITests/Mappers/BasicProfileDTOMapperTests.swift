//
//  BasicProfileDTOMapperTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 30/01/2025.
//

import Foundation
import ProfileDomain
import Testing

@testable import ProfileAPI

@Suite("BasicProfileDTOMapper")
struct BasicProfileDTOMapperTests {

    @Test("map from model with ID")
    func mapFromModelWithID() throws {
        let id = try #require(UUID(uuidString: "133E1176-F1BF-48D9-9515-6FEDBBC4B290"))
        let basicProfile = try Self.buildBasicProfile(id: id)

        let dto = BasicProfileDTOMapper.map(from: basicProfile)

        #expect(dto.id == id)
    }

    @Test("map from model with display name")
    func mapFromModelWithDisplayName() throws {
        let displayName = "Dave"
        let basicProfile = try Self.buildBasicProfile(displayName: displayName)

        let dto = BasicProfileDTOMapper.map(from: basicProfile)

        #expect(dto.displayName == displayName)
    }

}

extension BasicProfileDTOMapperTests {

    private static func buildBasicProfile(
        id: UUID? = UUID(uuidString: "A1F167AD-6FEC-4A48-8A55-775D2A645FB0"),
        userID: UUID? = UUID(uuidString: "54A3BB4B-1AC7-48E3-A92E-93D94AC125F9"),
        displayName: String = "",
        birthDate: Date = Date(timeIntervalSince1970: 0)
    ) throws -> BasicProfile {
        try BasicProfile(
            id: #require(id),
            userID: #require(userID),
            displayName: displayName,
            birthDate: birthDate
        )
    }

}
