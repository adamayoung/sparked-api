//
//  RegisterUserTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 29/01/2025.
//

import Foundation
import IdentityDomain
import Testing

@testable import IdentityApplication

@Suite("RegisterUser")
struct RegisterUserTests {

    let useCase: RegisterUser
    let repository: RegisterUserStubRepository
    let hasher: PasswordHasherStubService

    init() {
        self.repository = RegisterUserStubRepository()
        self.hasher = PasswordHasherStubService()
        self.useCase = RegisterUser(repository: repository, hasher: hasher)
    }

    @Test("execute when user created successfully returns user")
    func executeWhenUserCreatedSuccessfullyReturnsUser() async throws {
        let password = "Password123"
        let input = RegisterUserInput(
            firstName: "Dave",
            familyName: "Smith",
            email: "email@example.com",
            password: password,
            isVerified: true
        )
        let passwordHash = "321drowssaP"
        let user = try User(
            id: #require(UUID(uuidString: "BDE07538-4204-4F5E-9DB6-CF90A322C18D")),
            firstName: "Dave",
            familyName: "Smith",
            email: "email@example.com",
            passwordHash: passwordHash,
            isVerified: true,
            isActive: true
        )
        hasher.hashResult = .success(passwordHash)
        repository.createResult = .success(user)

        let userDTO = try await useCase.execute(input: input)

        #expect(userDTO.id == user.id)
        #expect(repository.createWasCalled)
        #expect(repository.lastCreateUser?.email == input.email)
        #expect(hasher.hashWasCalled)
        #expect(hasher.hashLastPassword == password)
    }

    @Test("execute when user creation failed throws error")
    func executeWhenUserCreationFailedThrowsError() async throws {
        let input = RegisterUserInput(
            firstName: "Dave",
            familyName: "Smith",
            email: "email@example.com",
            password: "Password123",
            isVerified: true
        )
        hasher.hashResult = .success("")
        repository.createResult = .failure(.unknown())

        await #expect(throws: RegisterUserError.unknown()) {
            _ = try await useCase.execute(input: input)
        }
        #expect(repository.createWasCalled)
    }

}
