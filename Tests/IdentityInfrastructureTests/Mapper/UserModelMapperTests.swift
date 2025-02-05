//
//  UserModelMapperTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 28/01/2025.
//

import Foundation
import IdentityApplication
import Testing

@testable import IdentityInfrastructure

@Suite("UserModelMapper")
struct UserModelMapperTests {

    let passwordHasher: PasswordHasherStubProvider

    init() {
        self.passwordHasher = PasswordHasherStubProvider()
    }

    @Test("map from register user input with first name")
    func mapFromRegisterUserInputWithFirstName() throws {
        let firstName = "Dave"
        let input = Self.buildRegisterUserInput(firstName: firstName)

        let userModel = try UserModelMapper.map(from: input, using: passwordHasher)

        #expect(userModel.firstName == firstName)
    }

    @Test("map from register user input with family name")
    func mapFromRegisterUserInputWithLastName() throws {
        let familyName = "Smith"
        let input = Self.buildRegisterUserInput(familyName: familyName)

        let userModel = try UserModelMapper.map(from: input, using: passwordHasher)

        #expect(userModel.familyName == familyName)
    }

    @Test("map from register user input with email")
    func mapFromRegisterUserInputWithEmail() throws {
        let email = "email@example.com"
        let input = Self.buildRegisterUserInput(email: email)

        let userModel = try UserModelMapper.map(from: input, using: passwordHasher)

        #expect(userModel.email == email)
    }

    @Test("map from register user input with password")
    func mapFromRegisterUserInputWithPassword() throws {
        let password = "password123"
        let expectedPassword = String("password123".reversed())
        let input = Self.buildRegisterUserInput(password: password)
        passwordHasher.hashResult = .success(expectedPassword)

        let userModel = try UserModelMapper.map(from: input, using: passwordHasher)

        #expect(userModel.password == expectedPassword)
        #expect(passwordHasher.hashLastPassword == password)
    }

}

extension UserModelMapperTests {

    private static func buildRegisterUserInput(
        firstName: String = "",
        familyName: String = "",
        email: String = "",
        password: String = "",
        isVerified: Bool = false,
        isAdmin: Bool = false
    ) -> RegisterUserInput {
        RegisterUserInput(
            firstName: firstName,
            familyName: familyName,
            email: email,
            password: password,
            isVerified: isVerified,
            isAdmin: isAdmin
        )
    }

}
