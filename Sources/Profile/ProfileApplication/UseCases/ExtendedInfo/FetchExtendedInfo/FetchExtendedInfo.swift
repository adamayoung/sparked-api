//
//  FetchExtendedInfo.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation
import ProfileDomain

final class FetchExtendedInfo: FetchExtendedInfoUseCase {

    private let repository: any ExtendedInfoRepository

    init(repository: any ExtendedInfoRepository) {
        self.repository = repository
    }

    func execute(
        id: ExtendedInfoDTO.ID,
        userContext: some UserContext
    ) async throws(FetchExtendedInfoError) -> ExtendedInfoDTO {
        let extendedInfo: ExtendedInfo
        do {
            extendedInfo = try await repository.fetch(byID: id)
        } catch ExtendedInfoRepositoryError.notFound {
            throw .notFound(id: id)
        } catch let error {
            throw .unknown(error)
        }

        guard userContext.canRead(ownerID: extendedInfo.ownerID) else {
            throw .unauthorized
        }

        let extendedInfoDTO = ExtendedInfoDTOMapper.map(from: extendedInfo)

        return extendedInfoDTO
    }

    func execute(
        userID: UUID,
        userContext: some UserContext
    ) async throws(FetchExtendedInfoError) -> ExtendedInfoDTO {
        let extendedInfo: ExtendedInfo
        do {
            extendedInfo = try await repository.fetch(byOwnerID: userID)
        } catch ExtendedInfoRepositoryError.notFound {
            throw .notFoundForUser(userID: userID)
        } catch let error {
            throw .unknown(error)
        }

        guard userContext.canRead(ownerID: extendedInfo.ownerID) else {
            throw .unauthorized
        }

        guard
            userContext.isOwner(extendedInfo.ownerID)
                || (userContext.isAdmin && userContext.isSystem)
        else {
            throw .unauthorized
        }

        let extendedInfoDTO = ExtendedInfoDTOMapper.map(from: extendedInfo)

        return extendedInfoDTO
    }

    func execute(
        profileID: ProfileDTO.ID,
        userContext: some UserContext
    ) async throws(FetchExtendedInfoError) -> ExtendedInfoDTO {
        let extendedInfo: ExtendedInfo
        do {
            extendedInfo = try await repository.fetch(byProfileID: profileID)
        } catch ExtendedInfoRepositoryError.notFound {
            throw .profileNotFound(profileID: profileID)
        } catch let error {
            throw .unknown(error)
        }

        guard userContext.canRead(ownerID: extendedInfo.ownerID) else {
            throw .unauthorized
        }

        let extendedInfoDTO = ExtendedInfoDTOMapper.map(from: extendedInfo)

        return extendedInfoDTO
    }

}
