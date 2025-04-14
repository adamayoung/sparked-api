//
//  CreateExtendedInfo.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation
import ProfileDomain

final class CreateExtendedInfo: CreateExtendedInfoUseCase {

    private let repository: any ExtendedInfoRepository
    private let basicProfileRepository: any BasicProfileRepository
    private let educationLevelRepository: any EducationLevelRepository
    private let starSignRepository: any StarSignRepository

    init(
        repository: some ExtendedInfoRepository,
        basicProfileRepository: some BasicProfileRepository,
        educationLevelRepository: some EducationLevelRepository,
        starSignRepository: some StarSignRepository
    ) {
        self.repository = repository
        self.basicProfileRepository = basicProfileRepository
        self.educationLevelRepository = educationLevelRepository
        self.starSignRepository = starSignRepository
    }

    func execute(
        input: CreateExtendedInfoInput,
        userContext: some UserContext
    ) async throws(CreateExtendedInfoError) -> ExtendedInfoDTO {
        let basicProfile = try await basicProfile(withID: input.profileID)
        guard userContext.canWrite(ownerID: basicProfile.ownerID) else {
            throw .unauthorized
        }

        try await validate(input: input)

        let extendedInfo = ExtendedInfoMapper.map(from: input, ownerID: basicProfile.ownerID)
        try await create(extendedInfo)

        let extendedInfoDTO = ExtendedInfoDTOMapper.map(from: extendedInfo)

        return extendedInfoDTO
    }

}

extension CreateExtendedInfo {

    private func basicProfile(
        withID id: UUID
    ) async throws(CreateExtendedInfoError) -> BasicProfile {
        let basicProfile: BasicProfile
        do {
            basicProfile = try await basicProfileRepository.fetch(byID: id)
        } catch BasicProfileRepositoryError.notFound {
            throw .profileNotFound(profileID: id)
        } catch let error {
            throw .unknown(error)
        }

        return basicProfile
    }

    private func create(_ extendedInfo: ExtendedInfo) async throws(CreateExtendedInfoError) {
        do {
            try await repository.create(extendedInfo)
        } catch ExtendedInfoRepositoryError.duplicate {
            throw .extendedInfoAlreadyExistsForProfile(profileID: extendedInfo.profileID)
        } catch let error {
            throw .unknown(error)
        }
    }

}

extension CreateExtendedInfo {

    private func validate(input: CreateExtendedInfoInput) async throws(CreateExtendedInfoError) {
        try await self.validate(educationLevelID: input.educationLevelID)
        try await self.validate(starSignID: input.starSignID)
    }

    private func validate(educationLevelID: UUID?) async throws(CreateExtendedInfoError) {
        guard let educationLevelID else {
            return
        }

        do {
            _ = try await educationLevelRepository.fetch(byID: educationLevelID)
        } catch EducationLevelRepositoryError.notFound {
            throw .educationLevelNotFound(educationLevelID: educationLevelID)
        } catch let error {
            throw .unknown(error)
        }
    }

    private func validate(starSignID: UUID?) async throws(CreateExtendedInfoError) {
        guard let starSignID else {
            return
        }

        do {
            _ = try await starSignRepository.fetch(byID: starSignID)
        } catch StarSignRepositoryError.notFound {
            throw .starSignNotFound(starSignID: starSignID)
        } catch let error {
            throw .unknown(error)
        }
    }

}
