//
//  RegisterUserInputMapperTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 30/01/2025.
//

import Foundation
import IdentityDomain
import Testing

@testable import IdentityAPI

@Suite("RegisterUserInputMapper")
struct RegisterUserInputMapperTests {

    @Test("map from dto with first name")
    func mapFromDTOWithFirstName() {
        let firstName = "Dave"
        let dto = Self.buildDTO(firstName: firstName)

        let input = RegisterUserInputMapper.map(from: dto)

        #expect(input.firstName == firstName)
    }

    @Test("map from dto with family name")
    func mapFromDTOWithLastName() {
        let familyName = "Smith"
        let dto = Self.buildDTO(familyName: familyName)

        let input = RegisterUserInputMapper.map(from: dto)

        #expect(input.familyName == familyName)
    }

    @Test("map from dto with email")
    func mapFromDTOWithEmail() {
        let email = "email@example.com"
        let dto = Self.buildDTO(email: email)

        let input = RegisterUserInputMapper.map(from: dto)

        #expect(input.email == email)
    }

    @Test("map from dto with password")
    func mapFromDTOWithPassword() {
        let password = "password123"
        let dto = Self.buildDTO(password: password)

        let input = RegisterUserInputMapper.map(from: dto)

        #expect(input.password == password)
    }

}

extension RegisterUserInputMapperTests {

    private static func buildDTO(
        firstName: String = "",
        familyName: String = "",
        email: String = "",
        password: String = ""
    ) -> RegisterUserDTO {
        RegisterUserDTO(
            firstName: firstName,
            familyName: familyName,
            email: email,
            password: password
        )
    }

}
