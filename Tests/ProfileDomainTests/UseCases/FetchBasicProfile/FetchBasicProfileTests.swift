//
//  FetchBasicProfileTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 30/01/2025.
//

import Foundation
import Testing

@testable import ProfileDomain

@Suite("FetchBasicProfile")
struct FetchBasicProfileTests {

    let useCase: FetchBasicProfile
    let repository: FetchBasicProfileStubRepository

    init() {
        self.repository = FetchBasicProfileStubRepository()
        self.useCase = FetchBasicProfile(repository: repository)
    }

    @Test("execute when basic profile fetched by ID returns basic profile")
    func executeWhenBasicProfileFetchedByIDReturnsBasicProfile() async throws {
        let id = try #require(UUID(uuidString: "3065DD78-CC13-4EFD-A1F8-0FF58C07DA24"))

        let expectedBasicProfile = try BasicProfile(
            id: id,
            userID: #require(UUID(uuidString: "12B46C87-AC38-43B5-B197-983BA2810EBC")),
            displayName: "Dave",
            birthDate: Date(timeIntervalSince1970: 0)
        )

        repository.fetchByIDResult = .success(expectedBasicProfile)

        let basicProfile = try await useCase.execute(id: id)

        #expect(basicProfile == expectedBasicProfile)
        #expect(repository.lastFetchByIDID == id)
    }

    @Test("execute when fetching basic profile by ID fails throws error")
    func executeWhenFetchingBasicProfileByIDFailsThrowsError() async throws {
        let id = try #require(UUID(uuidString: "3065DD78-CC13-4EFD-A1F8-0FF58C07DA24"))
        repository.fetchByIDResult = .failure(.unknown())

        await #expect(throws: FetchBasicProfileError.unknown()) {
            _ = try await useCase.execute(id: id)
        }
    }

    @Test("execute when basic profile fetched by user ID returns basic profile")
    func executeWhenBasicProfileFetchedByUserIDReturnsBasicProfile() async throws {
        let userID = try #require(UUID(uuidString: "12B46C87-AC38-43B5-B197-983BA2810EBC"))

        let expectedBasicProfile = try BasicProfile(
            id: #require(UUID(uuidString: "3065DD78-CC13-4EFD-A1F8-0FF58C07DA24")),
            userID: userID,
            displayName: "Dave",
            birthDate: Date(timeIntervalSince1970: 0)
        )

        repository.fetchByUserIDResult = .success(expectedBasicProfile)

        let basicProfile = try await useCase.execute(userID: userID)

        #expect(basicProfile == expectedBasicProfile)
        #expect(repository.lastFetchByUserIDUserID == userID)
    }

    @Test("execute when fetching basic profile by user ID fails throws error")
    func executeWhenFetchingBasicProfileByUserIDFailsThrowsError() async throws {
        let userID = try #require(UUID(uuidString: "12B46C87-AC38-43B5-B197-983BA2810EBC"))
        repository.fetchByUserIDResult = .failure(.unknown())

        await #expect(throws: FetchBasicProfileError.unknown()) {
            _ = try await useCase.execute(userID: userID)
        }
    }

}
