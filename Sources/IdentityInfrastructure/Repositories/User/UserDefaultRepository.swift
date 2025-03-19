//
//  UserFluentRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 23/01/2025.
//

import Foundation
import IdentityApplication
import IdentityDomain

final class UserDefaultRepository: UserRepository {

    private let remoteDataSource: any UserRemoteDataSource

    init(remoteDataSource: some UserRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func create(_ user: User) async throws(UserRepositoryError) {
        let existingUser = try? await self.fetch(byEmail: user.email)

        guard existingUser == nil else {
            throw .duplicateEmail
        }

        try await remoteDataSource.create(user)
    }

    func fetch(byID id: User.ID) async throws(UserRepositoryError) -> User {
        let user = try await remoteDataSource.fetch(byID: id)

        return user
    }

    func fetch(byEmail email: String) async throws(UserRepositoryError) -> User {
        let user = try await remoteDataSource.fetch(byEmail: email)

        return user
    }

}
