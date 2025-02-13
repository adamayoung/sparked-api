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
    private let userService: any UserService
    private let countryService: any CountryService
    private let genderService: any GenderService

    init(
        repository: some BasicInfoRepository,
        userService: some UserService,
        countryService: some CountryService,
        genderService: some GenderService
    ) {
        self.repository = repository
        self.userService = userService
        self.countryService = countryService
        self.genderService = genderService
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
        let userExists: Bool
        do {
            userExists = try await userService.doesUserExist(withID: userID)
        } catch let error {
            throw .unknown(error)
        }

        guard userExists else {
            throw .userNotFound(userID: userID)
        }
    }

    private func validate(countryID: UUID) async throws(CreateBasicInfoError) {
        let countryExists: Bool
        do {
            countryExists = try await countryService.doesCountryExist(withID: countryID)
        } catch let error {
            throw .unknown(error)
        }

        guard countryExists else {
            throw .countryNotFound(countryID: countryID)
        }
    }

    private func validate(genderID: UUID) async throws(CreateBasicInfoError) {
        let genderExists: Bool
        do {
            genderExists = try await genderService.doesGenderExist(withID: genderID)
        } catch let error {
            throw .unknown(error)
        }

        guard genderExists else {
            throw .genderNotFound(genderID: genderID)
        }
    }

}
