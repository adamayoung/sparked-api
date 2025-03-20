//
//  FetchBasicInfoTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 11/02/2025.
//

import Foundation
import ProfileDomain
import Testing

@testable import ProfileApplication

@Suite("FetchBasicInfo")
struct FetchBasicInfoTests {

    let useCase: FetchBasicInfo
    let repository: BasicInfoStubRepository

    init() {
        self.repository = BasicInfoStubRepository()
        self.useCase = FetchBasicInfo(repository: repository)
    }

    @Test("execute returns basic info DTO")
    func executeReturnsBasicInfoDTO() async throws {
        let profileID = try #require(UUID(uuidString: "667AF4BA-7912-437C-B8FB-E72C1DE371B4"))
        let basicInfo = try BasicInfo(
            profileID: profileID,
            genderID: #require(UUID(uuidString: "7EE528D5-F9BF-4D8C-8E13-0A4F3799B083")),
            countryID: #require(UUID(uuidString: "B0B145D3-AB7B-4260-ACE0-79CEB23A775B")),
            location: "Location",
            homeTown: "Home town",
            workplace: "Workplace",
            ownerID: #require(UUID(uuidString: "34CDAC87-07CB-4170-84B1-78B756E20650"))
        )
        repository.fetchByProfileIDResult = .success(basicInfo)

        let basicInfoDTO = try await useCase.execute(
            profileID: profileID,
            userContext: UserContextStub.user
        )

        #expect(repository.fetchByProfileIDWasCalled)
        #expect(repository.lastFetchByProfileIDProfileID == profileID)
    }

    @Test("execute when fetch fails throws error")
    func executeWhenFetchFailsThrowsError() async throws {
        let profileID = try #require(UUID(uuidString: "667AF4BA-7912-437C-B8FB-E72C1DE371B4"))
        repository.fetchByProfileIDResult = .failure(.unknown())

        await #expect(throws: FetchBasicInfoError.unknown(BasicInfoRepositoryError.unknown())) {
            _ = try await useCase.execute(
                profileID: profileID,
                userContext: UserContextStub.user
            )
        }
        #expect(repository.fetchByProfileIDWasCalled)
        #expect(repository.lastFetchByProfileIDProfileID == profileID)
    }

}
