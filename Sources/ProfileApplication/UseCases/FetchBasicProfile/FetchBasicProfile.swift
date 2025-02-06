//
//  FetchBasicProfile.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation

package final class FetchBasicProfile: FetchBasicProfileUseCase {

    private let repository: any FetchBasicProfileRepository
    private let userService: any UserService

    package init(
        repository: some FetchBasicProfileRepository,
        userService: some UserService
    ) {
        self.repository = repository
        self.userService = userService
    }

    package func execute(
        id: BasicProfileDTO.ID
    ) async throws(FetchBasicProfileError) -> BasicProfileDTO {
        let basicProfile = try await repository.fetch(byID: id)
        let basicProfileDTO = BasicProfileDTOMapper.map(from: basicProfile)

        return basicProfileDTO
    }

    package func execute(userID: UUID) async throws(FetchBasicProfileError) -> BasicProfileDTO {
        do {
            _ = try await userService.fetch(byID: userID)
        } catch UserServiceError.notFound {
            throw .userNotFound(userID: userID)
        } catch let error {
            throw .unknown(error)
        }

        let basicProfile = try await repository.fetch(byUserID: userID)
        let basicProfileDTO = BasicProfileDTOMapper.map(from: basicProfile)

        return basicProfileDTO
    }

}
