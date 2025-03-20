//
//  FetchBasicInfoTests.swift
//  SparkedAPI
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
        let basicInfo = try BasicInfo.mock(profileID: profileID)
        repository.fetchByProfileIDResult = .success(basicInfo)

        _ = try await useCase.execute(
            profileID: profileID,
            userContext: UserMockContext.withUserRoleMock()
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
                userContext: UserMockContext.withUserRoleMock()
            )
        }
        #expect(repository.fetchByProfileIDWasCalled)
        #expect(repository.lastFetchByProfileIDProfileID == profileID)
    }

}
