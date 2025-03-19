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
        let basicProfile = try Self.createBasicProfile(id: id)

        repository.fetchByIDResult = .success(basicProfile)

        let basicProfileDTO = try await useCase.execute(id: id)

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
            _ = try await useCase.execute(id: id)
        }
        #expect(repository.fetchByIDWasCalled)
        #expect(repository.lastFetchByIDID == id)
    }

    @Test("execute by user ID when user and basic profile exists returns basic profile")
    func executeByUserIDWhenUserAndBasicProfileExistsReturnsBasicProfile() async throws {
        let userID = try #require(UUID(uuidString: "12B46C87-AC38-43B5-B197-983BA2810EBC"))
        let basicProfile = try Self.createBasicProfile(userID: userID)
        repository.fetchByUserIDResult = .success(basicProfile)

        let basicProfileDTO = try await useCase.execute(userID: userID)

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
            _ = try await useCase.execute(userID: userID)
        }
        #expect(repository.fetchByUserIDWasCalled)
        #expect(repository.lastFetchByUserIDUserID == userID)
    }

}

extension FetchBasicProfileTests {

    private static func createBasicProfile(
        id: UUID? = UUID(uuidString: "51045953-FA7E-47FF-A336-D608742031DF"),
        userID: UUID? = UUID(uuidString: "12B46C87-AC38-43B5-B197-983BA2810EBC"),
        displayName: String = "Dave",
        birthDate: Date = Date(timeIntervalSince1970: 0),
        bio: String = ""
    ) throws -> BasicProfile {
        try BasicProfile(
            id: #require(id),
            userID: #require(userID),
            displayName: displayName,
            birthDate: birthDate,
            bio: bio
        )
    }

}
