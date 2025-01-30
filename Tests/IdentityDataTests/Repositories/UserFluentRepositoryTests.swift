//
//  UserFluentRepositoryTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 28/01/2025.
//

import Fluent
import FluentPostgresDriver
import Foundation
import IdentityData
import IdentityDomain
import Testing
import XCTFluent

@testable import IdentityData

@Suite("UserFluentRepository")
struct UserFluentRepositoryTests {

    let repository: UserFluentRepository
    let database: ArrayTestDatabase
    let passwordHasher: PasswordHasherStubProvider

    init() {
        self.database = ArrayTestDatabase()
        self.passwordHasher = PasswordHasherStubProvider()
        self.repository = UserFluentRepository(
            database: database.db,
            passwordHasher: passwordHasher
        )
    }

    @Test("create when user with email does not exist creates user")
    func createWhenUserWithEmailDoesNotExistCreatesUser() async throws {
        let input = RegisterUserInput(
            firstName: "Dave",
            lastName: "Smith",
            email: "email@example.com",
            password: "password",
            isVerified: false,
            isAdmin: false
        )
        passwordHasher.hashResult = .success(input.password)
        database.append([TestOutput()])
        database.append([TestOutput()])

        let user = try await repository.create(input: input)

        #expect(user.email == input.email)
    }

    @Test("create when user with email does exist throws email already exists error")
    func createWhenUserWithEmailDoesExistThrowsEmailAlreadyExistsError() async throws {
        let input = RegisterUserInput(
            firstName: "Dave",
            lastName: "Smith",
            email: "email@example.com",
            password: "password",
            isVerified: false,
            isAdmin: false
        )
        let alreadyExistsUser = try #require(
            UserModel(
                id: UUID(uuidString: "CEBBCF99-BAEF-4629-8E5C-5079AC5029A4"),
                firstName: "Bob",
                lastName: "Robert",
                email: "email@example.com",
                password: "pass123",
                isVerified: true
            ))
        passwordHasher.hashResult = .success(String(input.password.reversed()))
        database.append([TestOutput(alreadyExistsUser)])

        await #expect(throws: RegisterUserError.emailAlreadyExists) {
            _ = try await repository.create(input: input)
        }
    }

    @Test("fetch by ID when user exists returns user")
    func fetchByIDWhenUserExistsReturnsUser() async throws {
        let id = try #require(UUID(uuidString: "05DE7EF2-460B-4837-A549-6D44E1649EF3"))
        let alreadyExistsUser = UserModel(
            id: id,
            firstName: "Bob",
            lastName: "Robert",
            email: "email@example.com",
            password: "pass123",
            isVerified: true
        )
        database.append([TestOutput(alreadyExistsUser)])

        let user = try await repository.fetch(byID: id)
        #expect(user.id == id)
    }

    @Test("fetch by ID when user does not exist throws not found error")
    func fetchByIDWhenUserDoesNotExistsThrowsNotFoundError() async throws {
        let id = try #require(UUID(uuidString: "05DE7EF2-460B-4837-A549-6D44E1649EF3"))
        database.append([])

        await #expect(throws: FetchUserError.notFound) {
            _ = try await repository.fetch(byID: id)
        }
    }

    @Test("fetch by email when user exists returns user")
    func fetchByEmailWhenUserExistsReturnsUser() async throws {
        let email = "email@example.com"
        let alreadyExistsUser = try UserModel(
            id: #require(UUID(uuidString: "05DE7EF2-460B-4837-A549-6D44E1649EF3")),
            firstName: "Bob",
            lastName: "Robert",
            email: email,
            password: "pass123",
            isVerified: true
        )
        database.append([TestOutput(alreadyExistsUser)])

        let user = try await repository.fetch(byEmail: email)
        #expect(user.email == email)
    }

    @Test("fetch by email when user does not exist throws not found error")
    func fetchByEmailWhenUserDoesNotExistsThrowsNotFoundError() async throws {
        let email = "email@example.com"
        database.append([])

        await #expect(throws: FetchUserError.notFound) {
            _ = try await repository.fetch(byEmail: email)
        }
    }

    @Test(
        "authenticate with email and password when user exists with matching email and password returns user"
    )
    func authenticateWithEmailAndPasswordWhenUserExistsWithMatchingEmailAndPasswordReturnsUser()
        async throws
    {
        let email = "email@example.com"
        let password = "123"
        let storedPassword = "321"
        let alreadyExistsUser = try UserModel(
            id: #require(UUID(uuidString: "05DE7EF2-460B-4837-A549-6D44E1649EF3")),
            firstName: "Bob",
            lastName: "Robert",
            email: email,
            password: storedPassword,
            isVerified: true
        )
        database.append([TestOutput(alreadyExistsUser)])
        passwordHasher.verifyResult = .success(true)

        let user = try await repository.authenticate(email: email, password: password)

        #expect(user.email == email)
        #expect(passwordHasher.verifyLastPassword == password)
        #expect(passwordHasher.verifyLastCreated == storedPassword)
    }

    @Test(
        "authenticate with email and password when user with email does not exist throws invalid email or password error"
    )
    func
        authenticateWithEmailAndPasswordWhenUserWithEmailDoesNotExistThrowsInvalidEmailOrPasswordError()
        async throws
    {
        let email = "email@example.com"
        let password = "123"
        database.append([])
        passwordHasher.verifyResult = .success(true)

        await #expect(throws: AuthenticateUserError.invalidEmailOrPassword) {
            _ = try await repository.authenticate(email: email, password: password)
        }
    }

    @Test(
        "authenticate with email and password when user with email exists but password mismatch throws invalid email or password error"
    )
    func
        authenticateWithEmailAndPasswordWhenUserWithEmailExistsButPasswordMismatchThrowsInvalidEmailOrPasswordError()
        async throws
    {
        let email = "email@example.com"
        let alreadyExistsUser = try UserModel(
            id: #require(UUID(uuidString: "05DE7EF2-460B-4837-A549-6D44E1649EF3")),
            firstName: "Bob",
            lastName: "Robert",
            email: email,
            password: "321",
            isVerified: true
        )
        database.append([TestOutput(alreadyExistsUser)])
        passwordHasher.verifyResult = .success(false)

        await #expect(throws: AuthenticateUserError.invalidEmailOrPassword) {
            _ = try await repository.authenticate(email: email, password: "incorrect-password")
        }
    }

}
