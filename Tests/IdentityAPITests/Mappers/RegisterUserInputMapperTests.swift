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

    @Test("map from dto with last name")
    func mapFromDTOWithLastName() {
        let lastName = "Smith"
        let dto = Self.buildDTO(lastName: lastName)

        let input = RegisterUserInputMapper.map(from: dto)

        #expect(input.lastName == lastName)
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
        lastName: String = "",
        email: String = "",
        password: String = ""
    ) -> RegisterUserDTO {
        RegisterUserDTO(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password
        )
    }

}
