//
//  UserFluentRemoteDataSourceTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Fluent
import Foundation
import IdentityApplication
import IdentityDomain
import Testing
import XCTFluent

@testable import IdentityInfrastructure

@Suite("UserFluentRemoteDataSource")
struct UserFluentRemoteDataSourceTests {

    let dataSource: UserFluentRemoteDataSource
    let database: ArrayTestDatabase

    init() {
        self.database = ArrayTestDatabase()
        self.dataSource = UserFluentRemoteDataSource(database: database.db)
    }

    @Test("create when user with email does not exist creates user", .disabled())
    func createWhenUserWithEmailDoesNotExistCreatesUser() async throws {
        let user = try Self.buildUser()
        let roles = try [Self.buildRole()]
        database.append([TestOutput()])
        database.append([TestOutput()])
        database.append([TestOutput()])

        await #expect(throws: Never.self) {
            try await dataSource.create(user, withRoles: roles)
        }
    }

    @Test("create when user with email does exist throws email already exists error")
    func createWhenUserWithEmailDoesExistThrowsEmailAlreadyExistsError() async throws {
        let id = try #require(UUID(uuidString: "05DE7EF2-460B-4837-A549-6D44E1649EF3"))
        let email = "dave@example.com"
        let user = try Self.buildUser(id: id, email: email)
        let roles = try [Self.buildRole()]
        let alreadyExistsUserModel = Self.buildUserModel(id: id, email: email)
        database.append([TestOutput(alreadyExistsUserModel)])

        await #expect(throws: UserRepositoryError.duplicateEmail) {
            try await dataSource.create(user, withRoles: roles)
        }
    }

    @Test("fetch by ID when user exists returns user")
    func fetchByIDWhenUserExistsReturnsUser() async throws {
        let id = try #require(UUID(uuidString: "05DE7EF2-460B-4837-A549-6D44E1649EF3"))
        let alreadyExistsUserModel = UserModel(
            id: id,
            firstName: "Bob",
            familyName: "Robert",
            email: "email@example.com",
            password: "pass123",
            isVerified: true
        )
        database.append([TestOutput(alreadyExistsUserModel)])

        let user = try await dataSource.fetch(byID: id)
        #expect(user.id == id)
    }

    @Test("fetch by ID when user does not exist throws not found error")
    func fetchByIDWhenUserDoesNotExistsThrowsNotFoundError() async throws {
        let id = try #require(UUID(uuidString: "05DE7EF2-460B-4837-A549-6D44E1649EF3"))
        database.append([])

        await #expect(throws: UserRepositoryError.notFound) {
            _ = try await dataSource.fetch(byID: id)
        }
    }

    @Test("fetch by email when user exists returns user")
    func fetchByEmailWhenUserExistsReturnsUser() async throws {
        let email = "email@example.com"
        let alreadyExistsUserModel = try UserModel(
            id: #require(UUID(uuidString: "05DE7EF2-460B-4837-A549-6D44E1649EF3")),
            firstName: "Bob",
            familyName: "Robert",
            email: email,
            password: "pass123",
            isVerified: true
        )
        database.append([TestOutput(alreadyExistsUserModel)])

        let user = try await dataSource.fetch(byEmail: email)
        #expect(user.email == email)
    }

    @Test("fetch by email when user does not exist throws not found error")
    func fetchByEmailWhenUserDoesNotExistsThrowsNotFoundError() async throws {
        let email = "email@example.com"
        database.append([])

        await #expect(throws: UserRepositoryError.notFound) {
            _ = try await dataSource.fetch(byEmail: email)
        }
    }

}

extension UserFluentRemoteDataSourceTests {

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

    private static func buildRole(
        id: UUID? = UUID(uuidString: "BB736BCD-67AA-4D79-A10A-44C93800B528"),
        code: String = "USER",
        name: String = "User",
        description: String = "User role"
    ) throws -> Role {
        try Role(
            id: #require(id),
            code: code,
            name: name,
            description: description
        )
    }

    private static func buildUserModel(
        id: UUID? = nil,
        firstName: String = "Bob",
        familyName: String = "Robert",
        email: String = "email@example.com",
        password: String = "pass123",
        isVerified: Bool = true
    ) -> UserModel {
        UserModel(
            id: id,
            firstName: firstName,
            familyName: familyName,
            email: email,
            password: password,
            isVerified: isVerified
        )
    }

}
