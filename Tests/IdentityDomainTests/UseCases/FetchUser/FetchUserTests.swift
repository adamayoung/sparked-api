//
//  FetchUserTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 29/01/2025.
//

import Foundation
import IdentityEntities
import Testing

@testable import IdentityDomain

@Suite("FetchUser")
struct FetchUserTests {

    let useCase: FetchUser
    let repository: FetchUserStubRepository

    init() {
        self.repository = FetchUserStubRepository()
        self.useCase = FetchUser(repository: repository)
    }

    @Test("execute when user found returns user")
    func executeWhenUserFoundReturnsUser() async throws {
        let id = try #require(UUID(uuidString: "12B46C87-AC38-43B5-B197-983BA2810EBC"))
        let expectedUser = User(
            id: id,
            firstName: "Dave",
            lastName: "Smith",
            email: "email@example.com",
            isVerified: true,
            isActive: true
        )
        repository.fetchResult = .success(expectedUser)

        let user = try await useCase.execute(id: id)

        #expect(user == expectedUser)
        #expect(repository.lastFetchID == id)
    }

    @Test("execute when user fetch fails throws error")
    func executeWhenUserFetchFailsThrowsError() async throws {
        let id = try #require(UUID(uuidString: "12B46C87-AC38-43B5-B197-983BA2810EBC"))
        repository.fetchResult = .failure(.unknown())

        await #expect(throws: FetchUserError.unknown()) {
            _ = try await useCase.execute(id: id)
        }
    }

}
