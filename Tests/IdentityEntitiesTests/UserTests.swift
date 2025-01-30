//
//  IdentityEntitiesTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 22/01/2025.
//

import Foundation
import Testing

@testable import IdentityEntities

@Suite("User")
struct UserTests {

    @Test("fullName")
    func fullNameReturnsFirstNameAndLastName() throws {
        let firstName = "Dave"
        let lastName = "Smith"
        let user = try User(
            id: #require(UUID(uuidString: "EFFE208D-7164-4CED-907E-278CB16A4C73")),
            firstName: firstName,
            lastName: lastName,
            email: "email@example.com",
            isVerified: true,
            isActive: true
        )

        var components = PersonNameComponents()
        components.givenName = firstName
        components.familyName = lastName
        let formatter = PersonNameComponentsFormatter()
        let expectedFullName = formatter.string(from: components)

        let fullName = user.fullName

        #expect(fullName == expectedFullName)
    }

}
