//
//  FetchBasicProfileTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 30/01/2025.
//

import Foundation
import ProfileDomain
import Testing

@testable import ProfileApplication

@Suite("FetchBasicProfile")
struct FetchBasicProfileTests {

    let useCase: FetchBasicProfile
    let repository: BasicProfileStubRepository

    init() {
        self.repository = BasicProfileStubRepository()
        self.useCase = FetchBasicProfile(repository: repository)
    }

    @Test("execute by ID when basic profile exists returns basic profile DTO")
    func executeByIDWhenBasicProfileExistsReturnsBasicProfile() async throws {
        let id = try #require(UUID(uuidString: "3065DD78-CC13-4EFD-A1F8-0FF58C07DA24"))
        let basicProfile = try BasicProfile.mock(id: id)

        repository.fetchByIDResult = .success(basicProfile)

        let basicProfileDTO = try await useCase.execute(
            id: id,
            userContext: UserMockContext.withUserRoleMock()
        )

        #expect(basicProfileDTO.id == basicProfile.id)
        #expect(repository.fetchByIDWasCalled)
        #expect(repository.lastFetchByIDID == id)
    }

    @Test("execute by ID when fetching basic profile fails throws error")
    func executeByIDWhenFetchingBasicProfileFailsThrowsError() async throws {
        let id = try #require(UUID(uuidString: "3065DD78-CC13-4EFD-A1F8-0FF58C07DA24"))
        repository.fetchByIDResult = .failure(.unknown())

        await #expect(throws: FetchBasicProfileError.unknown(BasicProfileRepositoryError.unknown()))
        {
            _ = try await useCase.execute(id: id, userContext: UserMockContext.withUserRoleMock())
        }
        #expect(repository.fetchByIDWasCalled)
        #expect(repository.lastFetchByIDID == id)
    }

    @Test("execute by user ID when user and basic profile exists returns basic profile")
    func executeByUserIDWhenUserAndBasicProfileExistsReturnsBasicProfile() async throws {
        let userContext = UserMockContext.withUserRoleMock()
        let userID = try #require(userContext.userID)
        let basicProfile = try BasicProfile.mock(ownerID: userID)
        repository.fetchByUserIDResult = .success(basicProfile)

        let basicProfileDTO = try await useCase.execute(
            userID: userID,
            userContext: userContext
        )

        #expect(basicProfileDTO.id == basicProfile.id)
        #expect(repository.fetchByUserIDWasCalled)
        #expect(repository.lastFetchByUserIDUserID == userID)
    }

    @Test("execute by user ID when user exists and fetching basic profile fails throws error")
    func executeWhenFetchingBasicProfileByUserIDFailsThrowsError() async throws {
        let userID = try #require(UUID(uuidString: "12B46C87-AC38-43B5-B197-983BA2810EBC"))
        repository.fetchByUserIDResult = .failure(.unknown())

        await #expect(
            throws: FetchBasicProfileError.unknown(BasicProfileRepositoryError.unknown())
        ) {
            _ = try await useCase.execute(
                userID: userID,
                userContext: UserMockContext.withUserRoleMock()
            )
        }
        #expect(repository.fetchByUserIDWasCalled)
        #expect(repository.lastFetchByUserIDUserID == userID)
    }

}
