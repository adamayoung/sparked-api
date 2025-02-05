//
//  UserFluentRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 23/01/2025.
//

import Fluent
import Foundation
import IdentityApplication
import IdentityDomain

package final class UserFluentRepository: UserRepository {

    private let database: any Database
    private let passwordHasher: any PasswordHasherProvider

    package init(
        database: some Database,
        passwordHasher: some PasswordHasherProvider
    ) {
        self.database = database
        self.passwordHasher = passwordHasher
    }

    package func create(
        input: RegisterUserInput
    ) async throws(RegisterUserError) -> User {
        guard (try? await self.fetch(byEmail: input.email)) == nil else {
            throw .emailAlreadyExists(email: input.email)
        }

        let userModel: UserModel
        do {
            userModel = try UserModelMapper.map(from: input, using: passwordHasher)
        } catch let error {
            throw .unknown(error)
        }

        do {
            try await userModel.save(on: database)
        } catch let error {
            throw .unknown(error)
        }

        let newUser: User
        do {
            newUser = try UserMapper.map(from: userModel)
        } catch let error {
            throw .unknown(error)
        }

        return newUser
    }

    package func fetch(byID id: User.ID) async throws(FetchUserError) -> User {
        let userModel: UserModel?
        do {
            userModel = try await UserModel.find(id, on: database)
        } catch let error {
            throw .unknown(error)
        }

        guard let userModel else {
            throw .notFoundByID(userID: id)
        }

        let user: User
        do {
            user = try UserMapper.map(from: userModel)
        } catch let error {
            throw .unknown(error)
        }

        return user
    }

    package func fetch(byEmail email: String) async throws(FetchUserError) -> User {
        let userModel: UserModel?
        do {
            userModel = try await UserModel.query(on: database)
                .filter(\.$email == email).first()
        } catch let error {
            throw .unknown(error)
        }

        guard let userModel else {
            throw .notFoundByEmail(email: email)
        }

        let user: User
        do {
            user = try UserMapper.map(from: userModel)
        } catch let error {
            throw .unknown(error)
        }

        return user
    }

    package func authenticate(
        email: String,
        password: String
    ) async throws(AuthenticateUserError) -> User {
        let userModel: UserModel?
        do {
            userModel = try await UserModel.query(on: database)
                .filter(\.$email == email)
                .first()
        } catch let error {
            throw .unknown(error)
        }

        guard let userModel else {
            throw .invalidEmailOrPassword
        }

        let isPasswordMatch: Bool
        do {
            isPasswordMatch = try passwordHasher.verify(password, created: userModel.password)
        } catch {
            throw .invalidEmailOrPassword
        }

        guard isPasswordMatch else {
            throw .invalidEmailOrPassword
        }

        let user: User
        do {
            user = try UserMapper.map(from: userModel)
        } catch let error {
            throw .unknown(error)
        }

        return user
    }

}
