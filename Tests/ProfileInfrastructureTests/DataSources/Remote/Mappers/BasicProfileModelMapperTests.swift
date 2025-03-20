//
//  BasicProfileModelMapperTests.swift
//  SparkedAPI
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
        let basicProfile = try BasicProfile.mock(id: id)

        let basicProfileModel = BasicProfileModelMapper.map(from: basicProfile)

        #expect(basicProfileModel.id == id)
    }

    @Test("map from create basic profile input with user ID")
    func mapFromCreateBasicProfileInputWithUserID() throws {
        let userID = try #require(UUID(uuidString: "CBCEC7E9-5038-422D-A3A1-779228BB31F2"))
        let basicProfile = try BasicProfile.mock(ownerID: userID)

        let basicProfileModel = BasicProfileModelMapper.map(from: basicProfile)

        #expect(basicProfileModel.ownerID == userID)
    }

    @Test("map from create basic profile input with display name")
    func mapFromCreateBasicProfileInputWithDisplayName() throws {
        let displayName = "Dave Smith"
        let basicProfile = try BasicProfile.mock(displayName: displayName)

        let basicProfileModel = BasicProfileModelMapper.map(from: basicProfile)

        #expect(basicProfileModel.displayName == displayName)
    }

    @Test("map from create basic profile input with birth date")
    func mapFromCreateBasicProfileInputWithBirthDate() throws {
        let birthDate = Date(timeIntervalSince1970: 20000)
        let basicProfile = try BasicProfile.mock(birthDate: birthDate)

        let basicProfileModel = BasicProfileModelMapper.map(from: basicProfile)

        #expect(basicProfileModel.birthDate == birthDate)
    }

}
