//
//  FetchProfile.swift
//  AdamDateApp
//
//  Created by Adam Young on 12/02/2025.
//

import Foundation
import ProfileDomain

final class FetchProfile: FetchProfileUseCase {

    private let basicProfileRepository: any BasicProfileRepository
    private let basicInfoRepository: any BasicInfoRepository

    init(
        basicProfileRepository: some BasicProfileRepository,
        basicInfoRepository: some BasicInfoRepository
    ) {
        self.basicProfileRepository = basicProfileRepository
        self.basicInfoRepository = basicInfoRepository
    }

    func execute(id: UUID) async throws(FetchProfileError) -> ProfileDTO {
        let basicProfile: BasicProfile
        let basicInfo: BasicInfo
        do {
            basicProfile = try await basicProfileRepository.fetch(byID: id)
            basicInfo = try await basicInfoRepository.fetch(byProfileID: basicProfile.id)
        } catch BasicProfileRepositoryError.notFound {
            throw .notFound(profileID: id)
        } catch BasicInfoRepositoryError.notFound {
            throw .notFound(profileID: id)
        } catch let error {
            throw .unknown(error)
        }

        let profileDTO = ProfileDTOMapper.map(from: basicProfile, basicInfo: basicInfo)

        return profileDTO
    }

    func execute(userID: UUID) async throws(FetchProfileError) -> ProfileDTO {
        let basicProfile: BasicProfile
        let basicInfo: BasicInfo
        do {
            basicProfile = try await basicProfileRepository.fetch(byUserID: userID)
            basicInfo = try await basicInfoRepository.fetch(byProfileID: basicProfile.id)
        } catch BasicProfileRepositoryError.notFound {
            throw .notFoundForUser(userID: userID)
        } catch BasicInfoRepositoryError.notFound {
            throw .notFoundForUser(userID: userID)
        } catch let error {
            throw .unknown(error)
        }

        let profileDTO = ProfileDTOMapper.map(from: basicProfile, basicInfo: basicInfo)

        return profileDTO
    }

}
