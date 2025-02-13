//
//  AuthenticateUserTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 29/01/2025.
//

import Foundation
import IdentityDomain
import Testing

@testable import IdentityApplication

@Suite("AuthenticateUser")
struct AuthenticateUserTests {

    let useCase: AuthenticateUser
    let repository: UserStubRepository
    let hasher: PasswordHasherStubService

    init() {
        self.repository = UserStubRepository()
        self.hasher = PasswordHasherStubService()
        self.useCase = AuthenticateUser(repository: repository, hasher: hasher)
    }

    @Test("execute when authentication is successful returns user")
    func executeWhenAuthenticationIsSuccessfulReturnsUser() async throws {
        let email = "email@example.com"
        let password = "testPassword"
        let credential = UserCredential(email: email, password: password)
        let user = try User(
            id: #require(UUID(uuidString: "0941E3F4-A620-40CD-A2BD-4E8D0655D8B0")),
            firstName: "Dave",
            familyName: "Smith",
            email: email,
            passwordHash: password,
            isVerified: true,
            isActive: true
        )
        repository.fetchByEmailResult = .success(user)

        let userDTO = try await useCase.execute(credential: credential)

        #expect(userDTO.id == user.id)
        #expect(repository.fetchByEmailWasCalled)
        #expect(repository.lastFetchByEmailEmail == email)
    }

    @Test("execute when authentication is unsuccessful throws error")
    func executeWhenAuthenticationIsUnsuccessfulThrowsError() async throws {
        let email = "email@example.com"
        let password = "testPassword"
        let credential = UserCredential(email: email, password: password)
        repository.fetchByEmailResult = .failure(.unknown())

        await #expect(throws: AuthenticateUserError.unknown(UserRepositoryError.unknown())) {
            _ = try await useCase.execute(credential: credential)
        }
        #expect(repository.fetchByEmailWasCalled)
    }

}
