//
//  UserModelMapperTests.swift
//  SparkedAPI
//
//  Created by Adam Young on 28/01/2025.
//

import Foundation
import IdentityApplication
import IdentityDomain
import Testing

@testable import IdentityInfrastructure

@Suite("UserModelMapper")
struct UserModelMapperTests {

    @Test("map from register user input with first name")
    func mapFromRegisterUserInputWithFirstName() throws {
        let firstName = "Dave"
        let user = try Self.buildUser(firstName: firstName)

        let userModel = UserModelMapper.map(from: user)

        #expect(userModel.firstName == firstName)
    }

    @Test("map from register user input with family name")
    func mapFromRegisterUserInputWithLastName() throws {
        let familyName = "Smith"
        let user = try Self.buildUser(familyName: familyName)

        let userModel = UserModelMapper.map(from: user)

        #expect(userModel.familyName == familyName)
    }

    @Test("map from register user input with email")
    func mapFromRegisterUserInputWithEmail() throws {
        let email = "email@example.com"
        let user = try Self.buildUser(email: email)

        let userModel = UserModelMapper.map(from: user)

        #expect(userModel.email == email)
    }

    @Test("map from register user input with password")
    func mapFromRegisterUserInputWithPassword() throws {
        let password = "password123"
        let user = try Self.buildUser(passwordHash: password)

        let userModel = UserModelMapper.map(from: user)

        #expect(userModel.password == password)
    }

}

extension UserModelMapperTests {

    private static func buildUser(
        id: UUID? = UUID(uuidString: "4DE011F6-C011-409E-BC6C-BC496D9EC47B"),
        firstName: String = "",
        familyName: String = "",
        email: String = "",
        passwordHash: String = "",
        isVerified: Bool = false,
        isAdmin: Bool = false
    ) throws -> User {
        User(
            id: try #require(id),
            firstName: firstName,
            familyName: familyName,
            email: email,
            passwordHash: passwordHash,
            isVerified: isVerified
        )
    }

}
