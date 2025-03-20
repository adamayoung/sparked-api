//
//  FetchBasicInfo.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation
import ProfileDomain

final class FetchBasicInfo: FetchBasicInfoUseCase {

    private let repository: any BasicInfoRepository

    init(repository: any BasicInfoRepository) {
        self.repository = repository
    }

    func execute(
        id: UUID,
        userContext: some UserContext
    ) async throws(FetchBasicInfoError) -> BasicInfoDTO {
        let basicInfo: BasicInfo
        do {
            basicInfo = try await repository.fetch(byID: id)
        } catch BasicInfoRepositoryError.notFound {
            throw .notFound(id: id)
        } catch let error {
            throw .unknown(error)
        }

        guard userContext.canRead(ownerID: basicInfo.ownerID) else {
            throw .unauthorized
        }

        let basicInfoDTO = BasicInfoDTOMapper.map(from: basicInfo)

        return basicInfoDTO
    }

    func execute(
        userID: UUID,
        userContext: some UserContext
    ) async throws(FetchBasicInfoError) -> BasicInfoDTO {
        let basicInfo: BasicInfo
        do {
            basicInfo = try await repository.fetch(byOwnerID: userID)
        } catch BasicInfoRepositoryError.notFound {
            throw .notFoundForUser(userID: userID)
        } catch let error {
            throw .unknown(error)
        }

        guard userContext.canRead(ownerID: basicInfo.ownerID) else {
            throw .unauthorized
        }

        guard
            userContext.isOwner(basicInfo.ownerID)
                || (userContext.isAdmin && userContext.isSystem)
        else {
            throw .unauthorized
        }

        let basicInfoDTO = BasicInfoDTOMapper.map(from: basicInfo)

        return basicInfoDTO
    }

    func execute(
        profileID: ProfileDTO.ID,
        userContext: some UserContext
    ) async throws(FetchBasicInfoError) -> BasicInfoDTO {
        let basicInfo: BasicInfo
        do {
            basicInfo = try await repository.fetch(byProfileID: profileID)
        } catch BasicInfoRepositoryError.notFound {
            throw .profileNotFound(profileID: profileID)
        } catch let error {
            throw .unknown(error)
        }

        guard userContext.canRead(ownerID: basicInfo.ownerID) else {
            throw .unauthorized
        }

        let basicInfoDTO = BasicInfoDTOMapper.map(from: basicInfo)

        return basicInfoDTO
    }

}
