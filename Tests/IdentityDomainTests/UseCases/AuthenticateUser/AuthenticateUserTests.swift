//
//  AuthenticateUserTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 29/01/2025.
//

import Foundation
import IdentityEntities
import Testing

@testable import IdentityDomain

@Suite("AuthenticateUser")
struct AuthenticateUserTests {

    let useCase: AuthenticateUser
    let repository: AuthenticateUserStubRepository

    init() {
        self.repository = AuthenticateUserStubRepository()
        self.useCase = AuthenticateUser(repository: repository)
    }

    @Test("execute when authentication is successful returns user")
    func executeWhenAuthenticationIsSuccessfulReturnsUser() async throws {
        let email = "email@example.com"
        let password = "testPassword"
        let credential = UserCredential(email: email, password: password)
        let expectedUser = try User(
            id: #require(UUID(uuidString: "0941E3F4-A620-40CD-A2BD-4E8D0655D8B0")),
            firstName: "Dave",
            lastName: "Smith",
            email: "email@example.com",
            isVerified: true,
            isActive: true
        )
        repository.authenticateResult = .success(expectedUser)

        let user = try await useCase.execute(credential: credential)

        #expect(user == expectedUser)
        #expect(repository.lastAuthenticateEmail == email)
        #expect(repository.lastAuthenticatePassword == password)
    }

    @Test("execute when authentication is unsuccessful throws error")
    func executeWhenAuthenticationIsUnsuccessfulThrowsError() async throws {
        let email = "email@example.com"
        let password = "testPassword"
        let credential = UserCredential(email: email, password: password)
        repository.authenticateResult = .failure(.unknown())

        await #expect(throws: AuthenticateUserError.unknown()) {
            _ = try await useCase.execute(credential: credential)
        }
    }

}
