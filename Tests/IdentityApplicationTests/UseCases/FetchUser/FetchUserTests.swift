//
//  FetchUserTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 29/01/2025.
//

import Foundation
import IdentityDomain
import Testing

@testable import IdentityApplication

@Suite("FetchUser")
struct FetchUserTests {

    let useCase: FetchUser
    let repository: UserStubRepository

    init() {
        self.repository = UserStubRepository()
        self.useCase = FetchUser(repository: repository)
    }

    @Test("execute when user found returns user")
    func executeWhenUserFoundReturnsUser() async throws {
        let id = try #require(UUID(uuidString: "12B46C87-AC38-43B5-B197-983BA2810EBC"))
        let user = User(
            id: id,
            firstName: "Dave",
            familyName: "Smith",
            email: "email@example.com",
            passwordHash: "Password123",
            isVerified: true,
            isActive: true
        )
        repository.fetchByIDResult = .success(user)

        let userDTO = try await useCase.execute(id: id)

        #expect(userDTO.id == user.id)
        #expect(repository.fetchByIDWasCalled)
        #expect(repository.lastFetchByIDID == id)
    }

    @Test("execute when user fetch fails throws error")
    func executeWhenUserFetchFailsThrowsError() async throws {
        let id = try #require(UUID(uuidString: "12B46C87-AC38-43B5-B197-983BA2810EBC"))
        repository.fetchByIDResult = .failure(.unknown())

        await #expect(throws: FetchUserError.unknown(UserRepositoryError.unknown())) {
            _ = try await useCase.execute(id: id)
        }
        #expect(repository.fetchByIDWasCalled)
    }

}
