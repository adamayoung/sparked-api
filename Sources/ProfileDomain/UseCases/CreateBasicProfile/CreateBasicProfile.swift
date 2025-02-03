//
//  CreateBasicProfile.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation

package final class CreateBasicProfile: CreateBasicProfileUseCase {

    private let repository: any CreateBasicProfileRepository

    package init(repository: some CreateBasicProfileRepository) {
        self.repository = repository
    }

    package func execute(
        input: CreateBasicProfileInput
    ) async throws(CreateBasicProfileError) -> BasicProfile {
        let profile = try await repository.create(input: input)
        return profile
    }

}
