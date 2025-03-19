//
//  CreateBasicProfileInputMapperTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 30/01/2025.
//

import Foundation
import ProfileApplication
import Testing

@testable import ProfileWebAPI

@Suite("CreateBasicProfileInputMapper")
struct CreateBasicProfileInputMapperTests {

    @Test("map from dto with user ID")
    func mapFromDTOWithUserID() throws {
        let requestModel = Self.buildRequestModel()
        let userID = try #require(UUID(uuidString: "9F13FAFD-68E1-4B25-AF20-E2317F806D9F"))

        let input = CreateBasicProfileInputMapper.map(from: requestModel, userID: userID)

        #expect(input.userID == userID)
    }

    @Test("map from dto with display name")
    func mapFromDTOWithDisplayName() throws {
        let displayName = "Dave"
        let requestModel = Self.buildRequestModel(displayName: displayName)
        let userID = try #require(UUID(uuidString: "9F13FAFD-68E1-4B25-AF20-E2317F806D9F"))

        let input = CreateBasicProfileInputMapper.map(from: requestModel, userID: userID)

        #expect(input.displayName == displayName)
    }

    @Test("map from dto with birth date")
    func mapFromDTOWithBirthDate() throws {
        let birthDate = Date(timeIntervalSince1970: 30000)
        let requestModel = Self.buildRequestModel(birthDate: birthDate)
        let userID = try #require(UUID(uuidString: "9F13FAFD-68E1-4B25-AF20-E2317F806D9F"))

        let input = CreateBasicProfileInputMapper.map(from: requestModel, userID: userID)

        #expect(input.birthDate == birthDate)
    }

}

extension CreateBasicProfileInputMapperTests {

    private static func buildRequestModel(
        displayName: String = "",
        birthDate: Date = Date(timeIntervalSince1970: 0),
        bio: String = ""
    ) -> CreateBasicProfileRequestModel {
        CreateBasicProfileRequestModel(
            displayName: displayName,
            birthDate: birthDate,
            bio: bio
        )
    }

}
