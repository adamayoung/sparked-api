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
    private let userService: any UserService

    package init(
        repository: some CreateBasicProfileRepository,
        userService: some UserService
    ) {
        self.repository = repository
        self.userService = userService
    }

    package func execute(
        input: CreateBasicProfileInput
    ) async throws(CreateBasicProfileError) -> BasicProfileDTO {
        do {
            try await userService.fetch(byID: input.userID)
        } catch UserServiceError.notFound {
            throw .userNotFound(userID: input.userID)
        } catch let error {
            throw .unknown(error)
        }

        let basicProfile = try await repository.create(input: input)
        let basicProfileDTO = BasicProfileDTOMapper.map(from: basicProfile)

        return basicProfileDTO
    }

}
