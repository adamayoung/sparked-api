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

package final class UserDefaultRepository: UserRepository {

    private let remoteDataSource: any UserRemoteDataSource

    package init(remoteDataSource: some UserRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    package func create(
        input: RegisterUserInput
    ) async throws(RegisterUserError) -> User {
        guard (try? await self.fetch(byEmail: input.email)) == nil else {
            throw .emailAlreadyExists(email: input.email)
        }

        let newUser = try await remoteDataSource.create(input: input)

        return newUser
    }

    package func fetch(byID id: User.ID) async throws(FetchUserError) -> User {
        let user = try await remoteDataSource.fetch(byID: id)

        return user
    }

    package func fetch(byEmail email: String) async throws(FetchUserError) -> User {
        let user = try await remoteDataSource.fetch(byEmail: email)

        return user
    }

    package func authenticate(
        email: String,
        password: String
    ) async throws(AuthenticateUserError) -> User {
        let user = try await remoteDataSource.authenticate(email: email, password: password)

        return user
    }

}
