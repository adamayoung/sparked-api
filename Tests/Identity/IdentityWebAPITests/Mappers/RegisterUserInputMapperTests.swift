//
//  RegisterUserInputMapperTests.swift
//  SparkedAPI
//
//  Created by Adam Young on 30/01/2025.
//

import Foundation
import IdentityApplication
import Testing

@testable import IdentityWebAPI

@Suite("RegisterUserInputMapper")
struct RegisterUserInputMapperTests {

    @Test("map from dto with first name")
    func mapFromDTOWithFirstName() {
        let firstName = "Dave"
        let requestModel = Self.buildRequestModel(firstName: firstName)

        let input = RegisterUserInputMapper.map(from: requestModel)

        #expect(input.firstName == firstName)
    }

    @Test("map from dto with family name")
    func mapFromDTOWithLastName() {
        let familyName = "Smith"
        let requestModel = Self.buildRequestModel(familyName: familyName)

        let input = RegisterUserInputMapper.map(from: requestModel)

        #expect(input.familyName == familyName)
    }

    @Test("map from dto with email")
    func mapFromDTOWithEmail() {
        let email = "email@example.com"
        let requestModel = Self.buildRequestModel(email: email)

        let input = RegisterUserInputMapper.map(from: requestModel)

        #expect(input.email == email)
    }

    @Test("map from dto with password")
    func mapFromDTOWithPassword() {
        let password = "password123"
        let requestModel = Self.buildRequestModel(password: password)

        let input = RegisterUserInputMapper.map(from: requestModel)

        #expect(input.password == password)
    }

}

extension RegisterUserInputMapperTests {

    private static func buildRequestModel(
        firstName: String = "",
        familyName: String = "",
        email: String = "",
        password: String = ""
    ) -> RegisterUserRequestModel {
        RegisterUserRequestModel(
            firstName: firstName,
            familyName: familyName,
            email: email,
            password: password
        )
    }

}
