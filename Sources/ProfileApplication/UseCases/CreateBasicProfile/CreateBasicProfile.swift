//
//  CreateBasicProfile.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation
import ProfileDomain

package final class CreateBasicProfile: CreateBasicProfileUseCase {

    private let repository: any CreateBasicProfileRepository

    package init(repository: some CreateBasicProfileRepository) {
        self.repository = repository
    }

    package func execute(
        input: CreateBasicProfileInput
    ) async throws(CreateBasicProfileError) -> BasicProfileDTO {
        let basicProfile = try await repository.create(input: input)
        let basicProfileDTO = BasicProfileDTOMapper.map(from: basicProfile)

        return basicProfileDTO
    }

}
