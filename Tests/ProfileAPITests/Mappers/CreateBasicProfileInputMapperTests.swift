//
//  CreateBasicProfileInputMapperTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 30/01/2025.
//

import Foundation
import ProfileDomain
import Testing

@testable import ProfileAPI

@Suite("CreateBasicProfileInputMapper")
struct CreateBasicProfileInputMapperTests {

    @Test("map from dto with user ID")
    func mapFromDTOWithUserID() throws {
        let dto = Self.buildCreateBasicProfileDTO()
        let userID = try #require(UUID(uuidString: "9F13FAFD-68E1-4B25-AF20-E2317F806D9F"))

        let input = CreateBasicProfileInputMapper.map(from: dto, userID: userID)

        #expect(input.userID == userID)
    }

    @Test("map from dto with display name")
    func mapFromDTOWithDisplayName() throws {
        let displayName = "Dave"
        let dto = Self.buildCreateBasicProfileDTO(displayName: displayName)
        let userID = try #require(UUID(uuidString: "9F13FAFD-68E1-4B25-AF20-E2317F806D9F"))

        let input = CreateBasicProfileInputMapper.map(from: dto, userID: userID)

        #expect(input.displayName == displayName)
    }

    @Test("map from dto with birth date")
    func mapFromDTOWithBirthDate() throws {
        let birthDate = Date(timeIntervalSince1970: 30000)
        let dto = Self.buildCreateBasicProfileDTO(birthDate: birthDate)
        let userID = try #require(UUID(uuidString: "9F13FAFD-68E1-4B25-AF20-E2317F806D9F"))

        let input = CreateBasicProfileInputMapper.map(from: dto, userID: userID)

        #expect(input.birthDate == birthDate)
    }

}

extension CreateBasicProfileInputMapperTests {

    private static func buildCreateBasicProfileDTO(
        displayName: String = "",
        birthDate: Date = Date(timeIntervalSince1970: 0)
    ) -> CreateBasicProfileDTO {
        CreateBasicProfileDTO(
            displayName: displayName,
            birthDate: birthDate
        )
    }

}
