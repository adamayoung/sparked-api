//
//  CreateBasicInfoTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 11/02/2025.
//

import Foundation
import ProfileDomain
import Testing

@testable import ProfileApplication

@Suite("CreateBasicInfo")
struct CreateBasicInfoTests {

    let useCase: CreateBasicInfo
    let repository: BasicInfoStubRepository
    let basicProfileRepository: BasicProfileStubRepository
    let countryRepository: CountryStubRepository
    let genderRepository: GenderStubRepository

    init() {
        self.repository = BasicInfoStubRepository()
        self.basicProfileRepository = BasicProfileStubRepository()
        self.countryRepository = CountryStubRepository()
        self.genderRepository = GenderStubRepository()
        self.useCase = CreateBasicInfo(
            repository: repository,
            basicProfileRepository: basicProfileRepository,
            countryRepository: countryRepository,
            genderRepository: genderRepository
        )
    }

    @Test("execute create basic info")
    func executeCreatesBasicInfo() async throws {
        let input = try CreateBasicInfoInput.mock()
        let userContext = UserMockContext.withUserRoleMock()
        let basicProfile = try BasicProfile.mock(ownerID: userContext.userID)
        let country = try Country.mock()
        let gender = try Gender.mock()

        repository.createResult = .success(Void())
        basicProfileRepository.fetchByIDResult = .success(basicProfile)
        countryRepository.fetchByIDResult = .success(country)
        genderRepository.fetchByIDResult = .success(gender)

        let basicInfoDTO = try await useCase.execute(input: input, userContext: userContext)

        #expect(repository.createWasCalled)
        #expect(repository.lastCreateBasicInfo != nil)
        #expect(basicInfoDTO.id == repository.lastCreateBasicInfo?.id)
    }

    @Test("execute when create fails throws error")
    func executeWhenCreateFailsThrowsError() async throws {
        let input = try CreateBasicInfoInput.mock()
        let userContext = UserMockContext.withUserRoleMock()
        let basicProfile = try BasicProfile.mock(ownerID: userContext.userID)
        let country = try Country.mock()
        let gender = try Gender.mock()

        repository.createResult = .failure(.unknown())
        basicProfileRepository.fetchByIDResult = .success(basicProfile)
        countryRepository.fetchByIDResult = .success(country)
        genderRepository.fetchByIDResult = .success(gender)

        await #expect(throws: CreateBasicInfoError.unknown(BasicInfoRepositoryError.unknown())) {
            _ = try await useCase.execute(
                input: input,
                userContext: userContext
            )
        }
    }

}
