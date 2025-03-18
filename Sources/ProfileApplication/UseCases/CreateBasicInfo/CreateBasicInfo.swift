//
//  CreateBasicInfo.swift
//  AdamDateApp
//
//  Created by Adam Young on 11/02/2025.
//

import Foundation
import ProfileDomain

final class CreateBasicInfo: CreateBasicInfoUseCase {

    private let repository: any BasicInfoRepository
    private let userRepository: any UserRepository
    private let countryRepository: any CountryRepository
    private let genderRepository: any GenderRepository

    init(
        repository: some BasicInfoRepository,
        userRepository: some UserRepository,
        countryRepository: some CountryRepository,
        genderRepository: some GenderRepository
    ) {
        self.repository = repository
        self.userRepository = userRepository
        self.countryRepository = countryRepository
        self.genderRepository = genderRepository
    }

    func execute(input: CreateBasicInfoInput) async throws(CreateBasicInfoError) -> BasicInfoDTO {
        try await validate(input: input)

        let basicInfo = BasicInfoMapper.map(from: input)
        do {
            try await repository.create(basicInfo)
        } catch BasicInfoRepositoryError.duplicate {
            throw .basicInfoAlreadyExistsForProfile(profileID: input.profileID)
        } catch let error {
            throw .unknown(error)
        }

        let basicInfoDTO = BasicInfoDTOMapper.map(from: basicInfo)

        return basicInfoDTO
    }

}

extension CreateBasicInfo {

    private func validate(input: CreateBasicInfoInput) async throws(CreateBasicInfoError) {
        try await self.validate(userID: input.userID)
        try await self.validate(countryID: input.countryID)
        try await self.validate(genderID: input.genderID)
    }

    private func validate(userID: UUID) async throws(CreateBasicInfoError) {
        do {
            _ = try await userRepository.fetch(byID: userID)
        } catch UserRepositoryError.notFound {
            throw .userNotFound(userID: userID)
        } catch let error {
            throw .unknown(error)
        }
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
