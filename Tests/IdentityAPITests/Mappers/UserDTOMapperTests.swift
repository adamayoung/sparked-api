//
//  UserDTOMapperTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 30/01/2025.
//

import Foundation
import IdentityEntities
import Testing

@testable import IdentityAPI

@Suite("UserDTOMapper")
struct UserDTOMapperTests {

    @Test("map from user with ID")
    func mapFromUserWithID() throws {
        let id = try #require(UUID(uuidString: "2E69B121-755A-49F0-B0CD-87859F72E053"))
        let user = try Self.buildUser(id: id)

        let dto = UserDTOMapper.map(from: user)

        #expect(dto.id == id)
    }

    @Test("map from user with first name")
    func mapFromUserWithFirstName() throws {
        let firstName = "Dave"
        let user = try Self.buildUser(firstName: firstName)

        let dto = UserDTOMapper.map(from: user)

        #expect(dto.firstName == firstName)
    }

    @Test("map from user with last name")
    func mapFromUserWithLastName() throws {
        let lastName = "Smith"
        let user = try Self.buildUser(lastName: lastName)

        let dto = UserDTOMapper.map(from: user)

        #expect(dto.lastName == lastName)
    }

    @Test("map from user with email")
    func mapFromUserWithEmail() throws {
        let email = "email@example.com"
        let user = try Self.buildUser(email: email)

        let dto = UserDTOMapper.map(from: user)

        #expect(dto.email == email)
    }

    @Test("map from user with is verified")
    func mapFromUserWithIsVerified() throws {
        let isVerified = true
        let user = try Self.buildUser(isVerified: isVerified)

        let dto = UserDTOMapper.map(from: user)

        #expect(dto.isVerified)
    }

}

extension UserDTOMapperTests {

    private static func buildUser(
        id: UUID? = UUID(uuidString: "0CC3CF79-E472-4D8A-BBEF-A0E8D3BDD88A"),
        firstName: String = "",
        lastName: String = "",
        email: String = "",
        isVerified: Bool = true,
        isActive: Bool = true
    ) throws -> User {
        User(
            id: try #require(id),
            firstName: firstName,
            lastName: lastName,
            email: email,
            isVerified: isVerified,
            isActive: isActive
        )
    }

}
