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

    package func create(_ user: User) async throws(RegisterUserError) {
        guard (try? await self.fetch(byEmail: user.email)) == nil else {
            throw .emailAlreadyExists(email: user.email)
        }

        try await remoteDataSource.create(user)
    }

    package func fetch(byID id: User.ID) async throws(FetchUserError) -> User {
        let user = try await remoteDataSource.fetch(byID: id)

        return user
    }

    package func fetch(byEmail email: String) async throws(FetchUserError) -> User {
        let user = try await remoteDataSource.fetch(byEmail: email)

        return user
    }

    package func fetchForAuthentication(
        byEmail email: String
    ) async throws(AuthenticateUserError) -> User {
        let user: User
        do {
            user = try await remoteDataSource.fetch(byEmail: email)
        } catch FetchUserError.notFoundByEmail {
            throw .invalidEmailOrPassword
        } catch let error {
            throw .unknown(error)
        }

        return user
    }

}
