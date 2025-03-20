//
//  RegisterUserTests.swift
//  SparkedAPI
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

    @Test("execute when user created successfully returns user")
    func executeWhenUserCreatedSuccessfullyReturnsUser() async throws {
        let password = "Password123"
        let input = RegisterUserInput.mock(password: password)
        let role = try Role.userMock()
        let passwordHash = "321drowssaP"
        let user = try User.mock(passwordHash: passwordHash)
        hasher.hashResult = .success(passwordHash)
        repository.createResult = .success(Void())
        roleRepository.fetchByCodeResult = .success(role)

        let userDTO = try await useCase.execute(input: input)

        #expect(userDTO.email == user.email)
        #expect(repository.createWasCalled)
        #expect(repository.lastCreateParameters?.user.email == input.email)
        #expect(hasher.hashWasCalled)
        #expect(hasher.lastHashParameter == password)
    }

    @Test("execute when user creation failed throws error")
    func executeWhenUserCreationFailedThrowsError() async throws {
        let input = RegisterUserInput.mock()
        let role = try Role.userMock()
        hasher.hashResult = .success("")
        roleRepository.fetchByCodeResult = .success(role)
        repository.createResult = .failure(.unknown())

        await #expect(throws: RegisterUserError.unknown(UserRepositoryError.unknown())) {
            _ = try await useCase.execute(input: input)
        }
        #expect(repository.createWasCalled)
    }

}
