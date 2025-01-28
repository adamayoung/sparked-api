//
//  FetchBasicProfile.swift
//  AdamDateAPI
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation
import ProfileEntities

package final class FetchBasicProfile: FetchBasicProfileUseCase {

    private let repository: any FetchBasicProfileRepository

    package init(repository: some FetchBasicProfileRepository) {
        self.repository = repository
    }

    package func execute(id: BasicProfile.ID) async throws(FetchBasicProfileError) -> BasicProfile {
        let profile = try await repository.fetch(byID: id)
        return profile
    }

    package func execute(userID: UUID) async throws(FetchBasicProfileError) -> BasicProfile {
        let profile = try await repository.fetch(byUserID: userID)
        return profile
    }

}
