//
//  FetchBasicProfile.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation

package final class FetchBasicProfile: FetchBasicProfileUseCase {

    private let repository: any FetchBasicProfileRepository

    package init(repository: some FetchBasicProfileRepository) {
        self.repository = repository
    }

    package func execute(
        id: BasicProfileDTO.ID
    ) async throws(FetchBasicProfileError) -> BasicProfileDTO {
        let basicProfile = try await repository.fetch(byID: id)
        let basicProfileDTO = BasicProfileDTOMapper.map(from: basicProfile)

        return basicProfileDTO
    }

    package func execute(userID: UUID) async throws(FetchBasicProfileError) -> BasicProfileDTO {
        let basicProfile = try await repository.fetch(byUserID: userID)
        let basicProfileDTO = BasicProfileDTOMapper.map(from: basicProfile)

        return basicProfileDTO
    }

}
