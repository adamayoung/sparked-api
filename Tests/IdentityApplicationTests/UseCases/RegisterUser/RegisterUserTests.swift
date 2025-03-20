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
    let repository: UserStubRepository
    let roleRepository: RoleStubRepository
    let hasher: PasswordHasherStubService

    init() {
        self.repository = UserStubRepository()
        self.roleRepository = RoleStubRepository()
        self.hasher = PasswordHasherStubService()
        self.useCase = RegisterUser(
            repository: repository,
            roleRepository: roleRepository,
            hasher: hasher
        )
    }

    @Test("execute when user created successfully returns user", .disabled())
    func executeWhenUserCreatedSuccessfullyReturnsUser() async throws {
        let password = "Password123"
        let input = RegisterUserInput(
            firstName: "Dave",
            familyName: "Smith",
            email: "email@example.com",
            password: password,
            isVerified: true,
            roles: ["USER"]
        )
        let role = try Role(
            id: #require(UUID(uuidString: "5AE6C277-CF2C-4943-A472-3A1351C9EF08")),
            code: "USER",
            name: "User",
            description: "User role"
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
        repository.createResult = .success(Void())
        roleRepository.fetchByCodeResult = .success(role)

        let userDTO = try await useCase.execute(input: input)

        #expect(userDTO.email == user.email)
        #expect(repository.createWasCalled)
        #expect(repository.lastCreateUser?.email == input.email)
        #expect(hasher.hashWasCalled)
        #expect(hasher.hashLastPassword == password)
    }

    @Test("execute when user creation failed throws error", .disabled())
    func executeWhenUserCreationFailedThrowsError() async throws {
        let input = RegisterUserInput(
            firstName: "Dave",
            familyName: "Smith",
            email: "email@example.com",
            password: "Password123",
            isVerified: true
        )
        let role = try Role(
            id: #require(UUID(uuidString: "5AE6C277-CF2C-4943-A472-3A1351C9EF08")),
            code: "USER",
            name: "User",
            description: "User role"
        )
        hasher.hashResult = .success("")
        roleRepository.fetchByCodeResult = .success(role)
        repository.createResult = .failure(.unknown())

        await #expect(throws: RegisterUserError.unknown(UserRepositoryError.unknown())) {
            _ = try await useCase.execute(input: input)
        }
        #expect(repository.createWasCalled)
    }

}
