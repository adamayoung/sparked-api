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

    func execute(id: UUID) async throws(FetchBasicInfoError) -> BasicInfoDTO {
        let basicInfo: BasicInfo
        do {
            basicInfo = try await repository.fetch(byID: id)
        } catch BasicInfoRepositoryError.notFound {
            throw .notFound(id: id)
        } catch let error {
            throw .unknown(error)
        }

        let basicInfoDTO = BasicInfoDTOMapper.map(from: basicInfo)

        return basicInfoDTO
    }

    func execute(userID: UUID) async throws(FetchBasicInfoError) -> BasicInfoDTO {
        let basicInfo: BasicInfo
        do {
            basicInfo = try await repository.fetch(byUserID: userID)
        } catch BasicInfoRepositoryError.notFound {
            throw .notFoundForUser(userID: userID)
        } catch let error {
            throw .unknown(error)
        }

        let basicInfoDTO = BasicInfoDTOMapper.map(from: basicInfo)

        return basicInfoDTO
    }

    func execute(profileID: ProfileDTO.ID) async throws(FetchBasicInfoError) -> BasicInfoDTO {
        let basicInfo: BasicInfo
        do {
            basicInfo = try await repository.fetch(byProfileID: profileID)
        } catch BasicInfoRepositoryError.notFound {
            throw .notFoundForProfile(profileID: profileID)
        } catch let error {
            throw .unknown(error)
        }

        let basicInfoDTO = BasicInfoDTOMapper.map(from: basicInfo)

        return basicInfoDTO
    }

}
