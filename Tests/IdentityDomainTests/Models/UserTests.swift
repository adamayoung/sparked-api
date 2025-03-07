//
//  UserTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 22/01/2025.
//

import Foundation
import Testing

@testable import IdentityDomain

@Suite("User")
struct UserTests {

    @Test("fullName")
    func fullNameReturnsFirstNameAndLastName() throws {
        let firstName = "Dave"
        let familyName = "Smith"
        let user = try User(
            id: #require(UUID(uuidString: "EFFE208D-7164-4CED-907E-278CB16A4C73")),
            firstName: firstName,
            familyName: familyName,
            email: "email@example.com",
            passwordHash: "Password123",
            isVerified: true,
            isActive: true
        )

        let expectedFullName = "\(firstName) \(familyName)"

        let fullName = user.fullName

        #expect(fullName == expectedFullName)
    }

}
