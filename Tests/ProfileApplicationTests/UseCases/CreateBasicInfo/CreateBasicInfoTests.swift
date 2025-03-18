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
    let userRepository: UserStubRepository
    let countryRepository: CountryStubRepository
    let genderRepository: GenderStubRepository

    init() {
        self.repository = BasicInfoStubRepository()
        self.userRepository = UserStubRepository()
        self.countryRepository = CountryStubRepository()
        self.genderRepository = GenderStubRepository()
        self.useCase = CreateBasicInfo(
            repository: repository,
            userRepository: userRepository,
            countryRepository: countryRepository,
            genderRepository: genderRepository
        )
    }

    @Test("execute create basic info")
    func executeCreatesBasicInfo() async throws {
        let input = try Self.makeInput()
        let user = try User(
            id: #require(UUID(uuidString: "EACE74E3-F428-457A-B9C7-B3276F36A355")),
            email: "some@email.com"
        )
        let country = try Country(
            id: #require(UUID(uuidString: "698DD1A8-B827-4511-930A-C6854C6A4948")),
            code: "GB",
            name: "United Kingdom"
        )
        let gender = try Gender(
            id: #require(UUID(uuidString: "D4906FA3-CDA1-4F0B-9631-809314451110")),
            code: "M",
            name: "Male"
        )

        repository.createResult = .success(Void())
        userRepository.fetchByIDResult = .success(user)
        countryRepository.fetchByIDResult = .success(country)
        genderRepository.fetchByIDResult = .success(gender)

        let basicInfoDTO = try await useCase.execute(input: input)

        #expect(repository.createWasCalled)
        #expect(repository.lastCreateBasicInfo != nil)
        #expect(basicInfoDTO.id == repository.lastCreateBasicInfo?.id)
    }

    @Test("execute when create fails throws error")
    func executeWhenCreateFailsThrowsError() async throws {
        let input = try Self.makeInput()
        let user = try User(
            id: #require(UUID(uuidString: "EACE74E3-F428-457A-B9C7-B3276F36A355")),
            email: "some@email.com"
        )
        let country = try Country(
            id: #require(UUID(uuidString: "698DD1A8-B827-4511-930A-C6854C6A4948")),
            code: "GB",
            name: "United Kingdom"
        )
        let gender = try Gender(
            id: #require(UUID(uuidString: "D4906FA3-CDA1-4F0B-9631-809314451110")),
            code: "M",
            name: "Male"
        )

        repository.createResult = .failure(.unknown())
        userRepository.fetchByIDResult = .success(user)
        countryRepository.fetchByIDResult = .success(country)
        genderRepository.fetchByIDResult = .success(gender)

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
