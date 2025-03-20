//
//  CreateBasicInfo.swift
//  SparkedAPI
//
//  Created by Adam Young on 11/02/2025.
//

import Foundation
import ProfileDomain

final class CreateBasicInfo: CreateBasicInfoUseCase {

    private let repository: any BasicInfoRepository
    private let basicProfileRepository: any BasicProfileRepository
    private let countryRepository: any CountryRepository
    private let genderRepository: any GenderRepository

    init(
        repository: some BasicInfoRepository,
        basicProfileRepository: some BasicProfileRepository,
        countryRepository: some CountryRepository,
        genderRepository: some GenderRepository
    ) {
        self.repository = repository
        self.basicProfileRepository = basicProfileRepository
        self.countryRepository = countryRepository
        self.genderRepository = genderRepository
    }

    func execute(
        input: CreateBasicInfoInput,
        userContext: some UserContext
    ) async throws(CreateBasicInfoError) -> BasicInfoDTO {
        let basicProfile = try await basicProfile(withID: input.profileID)
        guard userContext.canWrite(ownerID: basicProfile.ownerID) else {
            throw .unauthorized
        }

        try await validate(input: input)

        let basicInfo = BasicInfoMapper.map(from: input, ownerID: basicProfile.ownerID)
        try await create(basicInfo)

        let basicInfoDTO = BasicInfoDTOMapper.map(from: basicInfo)

        return basicInfoDTO
    }

}

extension CreateBasicInfo {

    private func basicProfile(
        withID id: UUID
    ) async throws(CreateBasicInfoError) -> BasicProfile {
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

    private func create(_ basicInfo: BasicInfo) async throws(CreateBasicInfoError) {
        do {
            try await repository.create(basicInfo)
        } catch BasicInfoRepositoryError.duplicate {
            throw .basicInfoAlreadyExistsForProfile(profileID: basicInfo.profileID)
        } catch let error {
            throw .unknown(error)
        }
    }

}

extension CreateBasicInfo {

    private func validate(input: CreateBasicInfoInput) async throws(CreateBasicInfoError) {
        try await self.validate(countryID: input.countryID)
        try await self.validate(genderID: input.genderID)
    }

    private func validate(countryID: UUID) async throws(CreateBasicInfoError) {
        do {
            _ = try await countryRepository.fetch(byID: countryID)
        } catch CountryRepositoryError.notFound {
            throw .countryNotFound(countryID: countryID)
        } catch let error {
            throw .unknown(error)
        }
    }

    private func validate(genderID: UUID) async throws(CreateBasicInfoError) {
        do {
            _ = try await genderRepository.fetch(byID: genderID)
        } catch GenderRepositoryError.notFound {
            throw .genderNotFound(genderID: genderID)
        } catch let error {
            throw .unknown(error)
        }
    }

}
