//
//  UserCredentialMapperTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 29/01/2025.
//

import Foundation
import IdentityApplication
import Testing

@testable import IdentityWebAPI

@Suite("UserCredentialMapper")
struct UserCredentialMapperTests {

    @Test("map from dto with email")
    func mapFromDTOWithEmail() {
        let email = "email@example.com"
        let requestModel = Self.buildRequestModel(email: email)

        let userCredential = UserCredentialMapper.map(from: requestModel)

        #expect(userCredential.email == email)
    }

    @Test("map from dto with password")
    func mapFromDTOWithPassword() {
        let password = "pass123"
        let requestModel = Self.buildRequestModel(password: password)

        let userCredential = UserCredentialMapper.map(from: requestModel)

        #expect(userCredential.password == password)
    }

}

extension UserCredentialMapperTests {

    private static func buildRequestModel(
        email: String = "",
        password: String = ""
    ) -> UserCredentialRequestModel {
        UserCredentialRequestModel(
            email: email,
            password: password
        )
    }

}
