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
        let userID = try #require(UUID(uuidString: "CBCEC7E9-5038-422D-A3A1-779228BB31F2"))
        let input = try Self.buildCreateBasicProfileInput(userID: userID)

        let basicProfile = BasicProfileModelMapper.map(from: input)

        #expect(basicProfile.userID == userID)
    }

    @Test("map from create basic profile input with display name")
    func mapFromCreateBasicProfileInputWithDisplayName() throws {
        let displayName = "Dave Smith"
        let input = try Self.buildCreateBasicProfileInput(displayName: displayName)

        let basicProfile = BasicProfileModelMapper.map(from: input)

        #expect(basicProfile.displayName == displayName)
    }

    @Test("map from create basic profile input with birth date")
    func mapFromCreateBasicProfileInputWithBirthDate() throws {
        let birthDate = Date(timeIntervalSince1970: 20000)
        let input = try Self.buildCreateBasicProfileInput(birthDate: birthDate)

        let basicProfile = BasicProfileModelMapper.map(from: input)

        #expect(basicProfile.birthDate == birthDate)
    }

}

extension BasicProfileModelMapperTests {

    private static func buildCreateBasicProfileInput(
        userID: UUID? = UUID(uuidString: "B743CB33-902E-40F3-9784-7C897EFBAE8A"),
        displayName: String = "",
        birthDate: Date = Date(timeIntervalSince1970: 0)
    ) throws -> CreateBasicProfileInput {
        try CreateBasicProfileInput(
            userID: #require(userID),
            displayName: displayName,
            birthDate: birthDate
        )
    }

}
