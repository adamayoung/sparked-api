//
//  BasicProfileTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 22/01/2025.
//

import Foundation
import Testing

@testable import ProfileDomain

@Suite("BasicProfile")
struct BasicProfileTests {

    @Test("age returns correct value")
    func ageReturnsCorrectValue() throws {
        let dateTenYearsAgo = try #require(
            Calendar.current.date(byAdding: .year, value: -10, to: Date()))
        let basicProfile = try buildBasicProfile(birthDate: dateTenYearsAgo)

        #expect(basicProfile.age == 10)
    }

}

extension BasicProfileTests {

    private func buildBasicProfile(
        id: UUID? = UUID(uuidString: "A641FB14-0CE1-45A4-A851-28664BB50C50"),
        userID: UUID? = UUID(uuidString: "ECE2D9AA-ED8D-4353-9F9C-33384B034436"),
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
