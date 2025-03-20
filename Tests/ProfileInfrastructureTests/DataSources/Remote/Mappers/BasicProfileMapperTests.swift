//
//  BasicProfileMapperTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 30/01/2025.
//

import Foundation
import Testing

@testable import ProfileInfrastructure

@Suite("BasicProfileMapper")
struct BasicProfileMapperTests {

    @Test("map from basic profile model with ID")
    func mapFromBasicProfileModelWithID() throws {
        let id = try #require(UUID(uuidString: "31037F6F-5F5B-45DB-B682-7FA6A4373BC9"))
        let basicProfileModel = try Self.buildBasicProfileModel(id: id)

        let basicProfile = try BasicProfileMapper.map(from: basicProfileModel)

        #expect(basicProfile.id == id)
    }

    @Test("map from basic profile model when ID is nil throws error")
    func mapFromBasicProfileModelWhenIDIsNilThrowsError() throws {
        let basicProfileModel = try Self.buildBasicProfileModel(id: nil)

        #expect(throws: Error.self) {
            _ = try BasicProfileMapper.map(from: basicProfileModel)
        }
    }

    @Test("map from basic profile model with user ID")
    func mapFromBasicProfileModelWithUserID() throws {
        let userID = try #require(UUID(uuidString: "60CCC12C-A927-4E52-BD70-EE9817648C2E"))
        let basicProfileModel = try Self.buildBasicProfileModel(ownerID: userID)

        let basicProfile = try BasicProfileMapper.map(from: basicProfileModel)

        #expect(basicProfile.ownerID == userID)
    }

    @Test("map from basic profile model with display name")
    func mapFromBasicProfileModelWithDisplayName() throws {
        let displayName = "Dave Smith"
        let basicProfileModel = try Self.buildBasicProfileModel(displayName: displayName)

        let basicProfile = try BasicProfileMapper.map(from: basicProfileModel)

        #expect(basicProfile.displayName == displayName)
    }

    @Test("map from basic profile model with birth date")
    func mapFromBasicProfileModelWithBirthDate() throws {
        let birthDate = Date(timeIntervalSinceNow: 10000)
        let basicProfileModel = try Self.buildBasicProfileModel(birthDate: birthDate)

        let basicProfile = try BasicProfileMapper.map(from: basicProfileModel)

        #expect(basicProfile.birthDate == birthDate)
    }

}

extension BasicProfileMapperTests {

    private static func buildBasicProfileModel(
        id: UUID? = UUID(uuidString: "373E4735-409C-4E9A-95A0-BE22DB4FA06B"),
        displayName: String = "",
        birthDate: Date = Date(timeIntervalSince1970: 0),
        bio: String = "",
        ownerID: UUID? = UUID(uuidString: "834C128C-614F-406C-883C-15521C8281BF")
    ) throws -> BasicProfileModel {
        try BasicProfileModel(
            id: id,
            displayName: displayName,
            birthDate: birthDate,
            bio: bio,
            ownerID: #require(ownerID)
        )
    }

}
