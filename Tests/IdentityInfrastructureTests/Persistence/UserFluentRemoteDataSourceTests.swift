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

    @Test("create when user with email does not exist creates user")
    func createWhenUserWithEmailDoesNotExistCreatesUser() async throws {
        let newUser = try Self.buildUser()
        database.append([TestOutput()])
        database.append([TestOutput()])

        let user = try await dataSource.create(user: newUser)

        #expect(user.id == newUser.id)
    }

    @Test("create when user with email does exist throws email already exists error")
    func createWhenUserWithEmailDoesExistThrowsEmailAlreadyExistsError() async throws {
        let id = try #require(UUID(uuidString: "05DE7EF2-460B-4837-A549-6D44E1649EF3"))
        let email = "dave@example.com"
        let newUser = try Self.buildUser(id: id, email: email)
        let alreadyExistsUserModel = Self.buildUserModel(id: id, email: email)
        database.append([TestOutput(alreadyExistsUserModel)])

        await #expect(throws: RegisterUserError.emailAlreadyExists(email: email)) {
            _ = try await dataSource.create(user: newUser)
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

        await #expect(throws: FetchUserError.notFoundByID(userID: id)) {
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

        await #expect(throws: FetchUserError.notFoundByEmail(email: email)) {
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
