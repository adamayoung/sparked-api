//
//  UserDTOMapperTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 30/01/2025.
//

import Foundation
import IdentityApplication
import Testing

@testable import IdentityWebAPI

@Suite("UserResponseModelMapper")
struct UserResponseModelMapperTests {

    @Test("map from user with ID")
    func mapFromUserWithID() throws {
        let id = try #require(UUID(uuidString: "2E69B121-755A-49F0-B0CD-87859F72E053"))
        let dto = try Self.buildDTO(id: id)

        let responseModel = UserResponseModelMapper.map(from: dto)

        #expect(responseModel.id == id)
    }

    @Test("map from user with first name")
    func mapFromUserWithFirstName() throws {
        let firstName = "Dave"
        let dto = try Self.buildDTO(firstName: firstName)

        let responseModel = UserResponseModelMapper.map(from: dto)

        #expect(responseModel.firstName == firstName)
    }

    @Test("map from user with family name")
    func mapFromUserWithLastName() throws {
        let familyName = "Smith"
        let dto = try Self.buildDTO(familyName: familyName)

        let responseModel = UserResponseModelMapper.map(from: dto)

        #expect(responseModel.familyName == familyName)
    }

    @Test("map from user with email")
    func mapFromUserWithEmail() throws {
        let email = "email@example.com"
        let dto = try Self.buildDTO(email: email)

        let responseModel = UserResponseModelMapper.map(from: dto)

        #expect(responseModel.email == email)
    }

    @Test("map from user with is verified")
    func mapFromUserWithIsVerified() throws {
        let isVerified = true
        let dto = try Self.buildDTO(isVerified: isVerified)

        let responseModel = UserResponseModelMapper.map(from: dto)

        #expect(responseModel.isVerified)
    }

}

extension UserResponseModelMapperTests {

    private static func buildDTO(
        id: UUID? = UUID(uuidString: "0CC3CF79-E472-4D8A-BBEF-A0E8D3BDD88A"),
        firstName: String = "",
        familyName: String = "",
        email: String = "",
        roles: [RoleDTO] = [],
        isVerified: Bool = true,
        isActive: Bool = true
    ) throws -> UserDTO {
        UserDTO(
            id: try #require(id),
            firstName: firstName,
            familyName: familyName,
            fullName: "\(firstName) \(familyName)",
            email: email,
            roles: roles,
            isVerified: isVerified,
            isActive: isActive
        )
    }

    private static func buildRoleDTO(
        id: UUID? = UUID(uuidString: "BB736BCD-67AA-4D79-A10A-44C93800B528"),
        code: String = "USER",
        name: String = "User",
        description: String = "User role"
    ) throws -> RoleDTO {
        try RoleDTO(
            id: #require(id),
            code: code,
            name: name,
            description: description
        )
    }

}
