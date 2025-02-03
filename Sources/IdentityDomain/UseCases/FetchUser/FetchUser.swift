//
//  FetchUser.swift
//  AdamDateAPI
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation

package final class FetchUser: FetchUserUseCase {

    private let repository: any FetchUserRepository

    package init(repository: some FetchUserRepository) {
        self.repository = repository
    }

    package func execute(id: User.ID) async throws(FetchUserError) -> User {
        let user = try await repository.fetch(byID: id)
        return user
    }

}
