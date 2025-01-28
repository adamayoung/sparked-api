//
//  UserMockRepository.swift
//  AdamDateAPI
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation
import IdentityDomain
import IdentityEntities

package final class UserMockRepository: UserRepository {

    private static let store = UserStore()
    private static let userPasswordStore = UserPasswordStore()

    private let passwordHasher: any PasswordHasherProvider

    package init(passwordHasher: some PasswordHasherProvider) {
        self.passwordHasher = passwordHasher
    }

    package func create(
        input: RegisterUserInput,
        isVerified: Bool
    ) async throws(RegisterUserError) -> User {
        guard await Self.store.get(byEmail: input.email) == nil else {
            throw .emailAlreadyExists
        }

        let id = UUID()
        let user = User(
            id: id,
            firstName: input.firstName,
            lastName: input.lastName,
            email: input.email,
            isVerified: isVerified,
            isActive: true
        )

        await Self.store.add(user: user)

        let hashedPassword: String
        do {
            hashedPassword = try passwordHasher.hash(input.password)
        } catch let error {
            throw .unknown(error)
        }

        await Self.userPasswordStore.add(userID: user.id, password: hashedPassword)

        return user
    }

    package func authenticate<Password: StringProtocol>(
        email: String,
        password: Password
    ) async throws(AuthenticateUserError) -> User {
        guard let user = await Self.store.get(byEmail: email) else {
            throw .invalidEmailOrPassword
        }

        let hashedPassword: String
        do {
            hashedPassword = try passwordHasher.hash(password.description)
        } catch let error {
            throw .unknown(error)
        }

        try await Self.userPasswordStore.verify(userID: user.id, password: hashedPassword)

        return user
    }

    package func fetch(byID id: User.ID) async throws(FetchUserError) -> User {
        guard let user = await Self.store.get(byID: id) else {
            throw .notFound
        }

        return user
    }

}

private actor UserStore {

    private var users: [User.ID: User] = [:]

    init() {}

    func add(user: User) async {
        users[user.id] = user
    }

    func get(byID id: User.ID) async -> User? {
        guard let user = users[id], user.isActive else {
            return nil
        }

        return user
    }

    func get(byEmail email: String) async -> User? {
        users.first { $0.value.email == email }?.value
    }

}

private actor UserPasswordStore {

    private var passwords: [User.ID: String] = [:]

    init() {}

    func add(userID: User.ID, password: String) async {
        passwords[userID] = password
    }

    func verify(userID: User.ID, password: String) async throws(AuthenticateUserError) {
        guard let storedPassword = passwords[userID] else {
            throw .invalidEmailOrPassword
        }

        guard password.description == storedPassword.description else {
            throw .invalidEmailOrPassword
        }
    }

}
