//
//  RegisterUserTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 29/01/2025.
//

import Foundation
import IdentityEntities
import Testing

@testable import IdentityDomain

@Suite("RegisterUser")
struct RegisterUserTests {

    let useCase: RegisterUser
    let repository: RegisterUserStubRepository

    init() {
        self.repository = RegisterUserStubRepository()
        self.useCase = RegisterUser(repository: repository)
    }

    @Test("execute when user created successfully returns user")
    func executeWhenUserCreatedSuccessfullyReturnsUser() async throws {
        let input = RegisterUserInput(
            firstName: "Dave",
            lastName: "Smith",
            email: "email@example.com",
            password: "password",
            isVerified: true
        )
        let expectedUser = try User(
            id: #require(UUID(uuidString: "BDE07538-4204-4F5E-9DB6-CF90A322C18D")),
            firstName: "Dave",
            lastName: "Smith",
            email: "email@example.com",
            isVerified: true,
            isActive: true
        )
        repository.createResult = .success(expectedUser)

        let user = try await useCase.execute(input: input)

        #expect(user == expectedUser)
        #expect(repository.lastCreateInput == input)
    }

    @Test("execute when user creation failed throws error")
    func executeWhenUserCreationFailedThrowsError() async throws {
        let input = RegisterUserInput(
            firstName: "Dave",
            lastName: "Smith",
            email: "email@example.com",
            password: "password",
            isVerified: true
        )
        repository.createResult = .failure(.unknown())

        await #expect(throws: RegisterUserError.unknown()) {
            _ = try await useCase.execute(input: input)
        }
    }
}
