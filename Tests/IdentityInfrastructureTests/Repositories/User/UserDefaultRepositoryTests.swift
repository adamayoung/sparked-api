//
//  UserDefaultRepositoryTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 28/01/2025.
//

import Foundation
import IdentityApplication
import IdentityDomain
import Testing

@testable import IdentityInfrastructure

@Suite("UserDefaultRepository")
struct UserDefaultRepositoryTests {

    let repository: UserDefaultRepository
    let remoteDataSource: UserRemoteStubDataSource

    init() {
        self.remoteDataSource = UserRemoteStubDataSource()
        self.repository = UserDefaultRepository(
            remoteDataSource: self.remoteDataSource
        )
    }

    @Test("create when user with email does not exist creates user")
    func createWhenUserWithEmailDoesNotExistCreatesUser() async throws {
        let user = try Self.buildUser()
        remoteDataSource.createResult = .success(Void())

        try await repository.create(user)

        #expect(remoteDataSource.createWasCalled)
        #expect(remoteDataSource.lastCreateUser == user)
        #expect(remoteDataSource.fetchByEmailWasCalled)
        #expect(remoteDataSource.lastFetchByEmailEmail == user.email)
    }

    @Test("create when user with email does exist throws email already exists error")
    func createWhenUserWithEmailDoesExistThrowsEmailAlreadyExistsError() async throws {
        let email = "email@example.com"
        let user = try Self.buildUser(email: email)
        let alreadyExistsUser = try Self.buildUser(email: email)
        remoteDataSource.fetchByEmailResult = .success(alreadyExistsUser)

        await #expect(throws: UserRepositoryError.duplicateEmail) {
            try await repository.create(user)
        }
        #expect(!remoteDataSource.createWasCalled)
        #expect(remoteDataSource.lastCreateUser == nil)
        #expect(remoteDataSource.fetchByEmailWasCalled)
        #expect(remoteDataSource.lastFetchByEmailEmail == email)
    }

    @Test("fetch by ID when user exists returns user")
    func fetchByIDWhenUserExistsReturnsUser() async throws {
        let id = try #require(UUID(uuidString: "05DE7EF2-460B-4837-A549-6D44E1649EF3"))
        let alreadyExistsUser = try Self.buildUser(id: id)
        remoteDataSource.fetchByIDResult = .success(alreadyExistsUser)

        let user = try await repository.fetch(byID: id)

        #expect(user == alreadyExistsUser)
        #expect(remoteDataSource.fetchByIDWasCalled)
        #expect(remoteDataSource.lastFetchByIDID == id)
    }

    @Test("fetch by ID when user does not exist throws not found error")
    func fetchByIDWhenUserDoesNotExistsThrowsNotFoundError() async throws {
        let id = try #require(UUID(uuidString: "05DE7EF2-460B-4837-A549-6D44E1649EF3"))
        remoteDataSource.fetchByIDResult = .failure(.notFound)

        await #expect(throws: UserRepositoryError.notFound) {
            _ = try await repository.fetch(byID: id)
        }
        #expect(remoteDataSource.fetchByIDWasCalled)
        #expect(remoteDataSource.lastFetchByIDID == id)
    }

    @Test("fetch by email when user exists returns user")
    func fetchByEmailWhenUserExistsReturnsUser() async throws {
        let email = "email@example.com"
        let alreadyExistsUser = try Self.buildUser(email: email)
        remoteDataSource.fetchByEmailResult = .success(alreadyExistsUser)

        let user = try await repository.fetch(byEmail: email)

        #expect(user.email == email)
        #expect(remoteDataSource.fetchByEmailWasCalled)
        #expect(remoteDataSource.lastFetchByEmailEmail == email)
    }

    @Test("fetch by email when user does not exist throws not found error")
    func fetchByEmailWhenUserDoesNotExistsThrowsNotFoundError() async throws {
        let email = "email@example.com"
        remoteDataSource.fetchByEmailResult = .failure(.notFound)

        await #expect(throws: UserRepositoryError.notFound) {
            _ = try await repository.fetch(byEmail: email)
        }
        #expect(remoteDataSource.fetchByEmailWasCalled)
        #expect(remoteDataSource.lastFetchByEmailEmail == email)
    }

}

extension UserDefaultRepositoryTests {

    private static func buildUser(
        id: UUID? = UUID(uuidString: "05DE7EF2-460B-4837-A549-6D44E1649EF3"),
        firstName: String = "Bob",
        familyName: String = "Robert",
        email: String = "email@example.com",
        passwordHash: String = "pass123",
        isVerified: Bool = true,
        isActive: Bool = true
    ) throws -> User {
        try User(
            id: #require(id),
            firstName: firstName,
            familyName: familyName,
            email: email,
            passwordHash: passwordHash,
            isVerified: isVerified,
            isActive: isActive
        )
    }

}
