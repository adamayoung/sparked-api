//
//  AuthenticateUserTests.swift
//  SparkedAPI
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
    let roleRepository: RoleStubRepository
    let hasher: PasswordHasherStubService

    init() {
        self.repository = UserStubRepository()
        self.roleRepository = RoleStubRepository()
        self.hasher = PasswordHasherStubService()
        self.useCase = AuthenticateUser(
            repository: repository,
            roleRepository: roleRepository,
            hasher: hasher
        )
    }

    @Test("execute when authentication is successful returns user")
    func executeWhenAuthenticationIsSuccessfulReturnsUser() async throws {
        let email = "email@example.com"
        let password = "testPassword"
        let credential = UserCredential(email: email, password: password)
        let user = try User.mock(email: email, passwordHash: password)
        let roles = try [Role.userMock()]
        repository.fetchByEmailResult = .success(user)
        roleRepository.fetchAllForUserIDResult = .success(roles)

        let userDTO = try await useCase.execute(credential: credential)

        #expect(userDTO.id == user.id)
        #expect(repository.fetchByEmailWasCalled)
        #expect(repository.lastFetchByEmailParameter == email)
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
