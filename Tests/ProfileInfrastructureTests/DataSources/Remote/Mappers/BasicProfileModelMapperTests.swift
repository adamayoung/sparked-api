//
//  BasicProfileModelMapperTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 30/01/2025.
//

import Foundation
import ProfileDomain
import Testing

@testable import ProfileInfrastructure

@Suite("BasicProfileModelMapper")
struct BasicProfileModelMapperTests {

    @Test("map from create basic profile input with ID")
    func mapFromCreateBasicProfileInputWithID() throws {
        let id = try #require(UUID(uuidString: "A2E1BC65-5C3F-4E4D-8715-6734A8E830BB"))
        let basicProfile = try Self.buildBasicProfile(id: id)

        let basicProfileModel = BasicProfileModelMapper.map(from: basicProfile)

        #expect(basicProfileModel.id == id)
    }

    @Test("map from create basic profile input with user ID")
    func mapFromCreateBasicProfileInputWithUserID() throws {
        let userID = try #require(UUID(uuidString: "CBCEC7E9-5038-422D-A3A1-779228BB31F2"))
        let basicProfile = try Self.buildBasicProfile(ownerID: userID)

        let basicProfileModel = BasicProfileModelMapper.map(from: basicProfile)

        #expect(basicProfileModel.ownerID == userID)
    }

    @Test("map from create basic profile input with display name")
    func mapFromCreateBasicProfileInputWithDisplayName() throws {
        let displayName = "Dave Smith"
        let basicProfile = try Self.buildBasicProfile(displayName: displayName)

        let basicProfileModel = BasicProfileModelMapper.map(from: basicProfile)

        #expect(basicProfileModel.displayName == displayName)
    }

    @Test("map from create basic profile input with birth date")
    func mapFromCreateBasicProfileInputWithBirthDate() throws {
        let birthDate = Date(timeIntervalSince1970: 20000)
        let basicProfile = try Self.buildBasicProfile(birthDate: birthDate)

        let basicProfileModel = BasicProfileModelMapper.map(from: basicProfile)

        #expect(basicProfileModel.birthDate == birthDate)
    }

}

extension BasicProfileModelMapperTests {

    private static func buildBasicProfile(
        id: UUID? = UUID(uuidString: "EF5BB7F5-2662-4ADB-AAAF-8671AC04C5AE"),
        displayName: String = "",
        birthDate: Date = Date(timeIntervalSince1970: 0),
        bio: String = "",
        ownerID: UUID? = UUID(uuidString: "B743CB33-902E-40F3-9784-7C897EFBAE8A")
    ) throws -> BasicProfile {
        try BasicProfile(
            id: #require(id),
            displayName: displayName,
            birthDate: birthDate,
            bio: bio,
            ownerID: #require(ownerID)
        )
    }

}
