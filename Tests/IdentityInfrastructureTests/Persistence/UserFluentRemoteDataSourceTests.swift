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
    let passwordHasher: PasswordHasherStubProvider

    init() {
        self.database = ArrayTestDatabase()
        self.passwordHasher = PasswordHasherStubProvider()
        self.dataSource = UserFluentRemoteDataSource(
            database: database.db,
            passwordHasher: passwordHasher
        )
    }

    @Test("create when user with email does not exist creates user")
    func createWhenUserWithEmailDoesNotExistCreatesUser() async throws {
        let input = RegisterUserInput(
            firstName: "Dave",
            familyName: "Smith",
            email: "email@example.com",
            password: "password",
            isVerified: false,
            isAdmin: false
        )
        passwordHasher.hashResult = .success(input.password)
        database.append([TestOutput()])
        database.append([TestOutput()])

        let user = try await dataSource.create(input: input)

        #expect(user.email == input.email)
    }

    @Test("create when user with email does exist throws email already exists error")
    func createWhenUserWithEmailDoesExistThrowsEmailAlreadyExistsError() async throws {
        let input = RegisterUserInput(
            firstName: "Dave",
            familyName: "Smith",
            email: "email@example.com",
            password: "password",
            isVerified: false,
            isAdmin: false
        )
        let alreadyExistsUserModel = try #require(
            UserModel(
                id: UUID(uuidString: "CEBBCF99-BAEF-4629-8E5C-5079AC5029A4"),
                firstName: "Bob",
                familyName: "Robert",
                email: "email@example.com",
                password: "pass123",
                isVerified: true
            ))
        passwordHasher.hashResult = .success(String(input.password.reversed()))
        database.append([TestOutput(alreadyExistsUserModel)])

        await #expect(throws: RegisterUserError.emailAlreadyExists(email: input.email)) {
            _ = try await dataSource.create(input: input)
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

    @Test(
        "authenticate with email and password when user exists with matching email and password returns user"
    )
    func authenticateWithEmailAndPasswordWhenUserExistsWithMatchingEmailAndPasswordReturnsUser()
        async throws
    {
        let email = "email@example.com"
        let password = "123"
        let storedPassword = "321"
        let alreadyExistsUserModel = try UserModel(
            id: #require(UUID(uuidString: "05DE7EF2-460B-4837-A549-6D44E1649EF3")),
            firstName: "Bob",
            familyName: "Robert",
            email: email,
            password: storedPassword,
            isVerified: true
        )
        database.append([TestOutput(alreadyExistsUserModel)])
        passwordHasher.verifyResult = .success(true)

        let user = try await dataSource.authenticate(email: email, password: password)

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
            _ = try await dataSource.authenticate(email: email, password: password)
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
        let alreadyExistsUserModel = try UserModel(
            id: #require(UUID(uuidString: "05DE7EF2-460B-4837-A549-6D44E1649EF3")),
            firstName: "Bob",
            familyName: "Robert",
            email: email,
            password: "321",
            isVerified: true
        )
        database.append([TestOutput(alreadyExistsUserModel)])
        passwordHasher.verifyResult = .success(false)

        await #expect(throws: AuthenticateUserError.invalidEmailOrPassword) {
            _ = try await dataSource.authenticate(email: email, password: "incorrect-password")
        }
    }

}
