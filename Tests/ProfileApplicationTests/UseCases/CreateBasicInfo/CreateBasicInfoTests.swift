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
    let userService: UserStubService
    let countryService: CountryStubService
    let genderService: GenderStubService

    init() {
        self.repository = BasicInfoStubRepository()
        self.userService = UserStubService()
        self.countryService = CountryStubService()
        self.genderService = GenderStubService()
        self.useCase = CreateBasicInfo(
            repository: repository,
            userService: userService,
            countryService: countryService,
            genderService: genderService
        )
    }

    @Test("execute create basic info")
    func executeCreatesBasicInfo() async throws {
        let input = try Self.makeInput()
        repository.createResult = .success(Void())

        let basicInfoDTO = try await useCase.execute(input: input)

        #expect(repository.createWasCalled)
        #expect(repository.lastCreateBasicInfo != nil)
        #expect(basicInfoDTO.id == repository.lastCreateBasicInfo?.id)
    }

    @Test("execute when create fails throws error")
    func executeWhenCreateFailsThrowsError() async throws {
        let input = try Self.makeInput()
        repository.createResult = .failure(.unknown())

        await #expect(throws: CreateBasicInfoError.unknown(BasicInfoRepositoryError.unknown())) {
            _ = try await useCase.execute(input: input)
        }
    }

}

extension CreateBasicInfoTests {

    private static func makeInput(
        profileID: UUID? = UUID(uuidString: "3EFF438F-6F53-4C8E-B5B0-2D690DCB7B85"),
        userID: UUID? = UUID(uuidString: "06A37628-325F-4B49-B9D3-F92AB4881503"),
        genderID: UUID? = UUID(uuidString: "5801E71F-A4F4-450B-8F9E-5064089E533D"),
        countryID: UUID? = UUID(uuidString: "5298A411-9A18-4305-AEA5-B79F212050ED"),
        location: String = "Location",
        homeTown: String? = "Home town",
        workplace: String? = "Workplace"
    ) throws -> CreateBasicInfoInput {
        try CreateBasicInfoInput(
            userID: #require(userID),
            profileID: #require(profileID),
            genderID: #require(genderID),
            countryID: #require(countryID),
            location: location,
            homeTown: homeTown,
            workplace: workplace
        )

    }
}
