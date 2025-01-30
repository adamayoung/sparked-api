//
//  UserCredentialMapperTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 29/01/2025.
//

import Foundation
import Testing

@testable import IdentityAPI

@Suite
struct UserCredentialMapperTests {

    @Test("map from dto with email")
    func mapFromDTOWithEmail() {
        let email = "email@example.com"
        let dto = Self.buildDTO(email: email)

        let userCredential = UserCredentialMapper.map(from: dto)

        #expect(userCredential.email == email)
    }

    @Test("map from dto with password")
    func mapFromDTOWithPassword() {
        let password = "pass123"
        let dto = Self.buildDTO(password: password)

        let userCredential = UserCredentialMapper.map(from: dto)

        #expect(userCredential.password == password)
    }

}

extension UserCredentialMapperTests {

    private static func buildDTO(
        email: String = "",
        password: String = ""
    ) -> UserCredentialDTO {
        UserCredentialDTO(
            email: email,
            password: password
        )
    }

}
