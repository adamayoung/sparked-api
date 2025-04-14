//
//  FetchBasicProfile.swift
//  SparkedAPI
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation
import ProfileDomain

final class FetchBasicProfile: FetchBasicProfileUseCase {

    private let repository: any BasicProfileRepository

    init(repository: some BasicProfileRepository) {
        self.repository = repository
    }

    func execute(
        id: UUID,
        userContext: some UserContext
    ) async throws(FetchBasicProfileError) -> BasicProfileDTO {
        let basicProfile: BasicProfile
        do {
            basicProfile = try await repository.fetch(byID: id)
        } catch BasicProfileRepositoryError.notFound {
            throw .notFound(profileID: id)
        } catch let error {
            throw .unknown(error)
        }

        guard userContext.canRead(ownerID: basicProfile.ownerID) else {
            throw .unauthorized
        }

        let basicProfileDTO = BasicProfileDTOMapper.map(from: basicProfile)

        return basicProfileDTO
    }

    func execute(
        userID: UUID,
        userContext: some UserContext
    ) async throws(FetchBasicProfileError) -> BasicProfileDTO {
        let basicProfile: BasicProfile
        do {
            basicProfile = try await repository.fetch(byUserID: userID)
        } catch BasicProfileRepositoryError.notFound {
            throw .notFoundForUser(userID: userID)
        } catch let error {
            throw .unknown(error)
        }

        guard userContext.canRead(ownerID: basicProfile.ownerID) else {
            throw .unauthorized
        }

        guard
            userContext.isOwner(basicProfile.ownerID)
                || (userContext.isAdmin && userContext.isSystem)
        else {
            throw .unauthorized
        }

        let basicProfileDTO = BasicProfileDTOMapper.map(from: basicProfile)

        return basicProfileDTO
    }

}
