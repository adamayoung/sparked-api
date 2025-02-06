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
    let repository: FetchBasicProfileStubRepository
    let userService: UserStubService

    init() {
        self.repository = FetchBasicProfileStubRepository()
        self.userService = UserStubService()
        self.useCase = FetchBasicProfile(repository: repository, userService: userService)
    }

    @Test("execute by ID when basic profile exists returns basic profile")
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

        await #expect(throws: FetchBasicProfileError.unknown()) {
            _ = try await useCase.execute(id: id)
        }
        #expect(repository.fetchByIDWasCalled)
        #expect(repository.lastFetchByIDID == id)
    }

    @Test("execute by user ID when user and basic profile exists returns basic profile")
    func executeByUserIDWhenUserAndBasicProfileExistsReturnsBasicProfile() async throws {
        let userID = try #require(UUID(uuidString: "12B46C87-AC38-43B5-B197-983BA2810EBC"))
        let basicProfile = try Self.createBasicProfile(userID: userID)
        let userDTO = try Self.createUserDTO(id: userID)
        userService.fetchByIDResult = .success(userDTO)
        repository.fetchByUserIDResult = .success(basicProfile)

        let basicProfileDTO = try await useCase.execute(userID: userID)

        #expect(basicProfileDTO.id == basicProfile.id)
        #expect(userService.fetchByIDWasCalled)
        #expect(userService.lastFetchByIDID == userID)
        #expect(repository.fetchByUserIDWasCalled)
        #expect(repository.lastFetchByUserIDUserID == userID)
    }

    @Test("execute by user ID when user does not exist throws user not found error")
    func executeByUserIDWhenUserDoesNotExistThrowsUserNotFoundError() async throws {
        let userID = try #require(UUID(uuidString: "12B46C87-AC38-43B5-B197-983BA2810EBC"))
        userService.fetchByIDResult = .failure(.notFound)

        await #expect(throws: FetchBasicProfileError.userNotFound(userID: userID)) {
            _ = try await useCase.execute(userID: userID)
        }
        #expect(userService.fetchByIDWasCalled)
        #expect(userService.lastFetchByIDID == userID)
        #expect(!repository.fetchByUserIDWasCalled)
    }

    @Test("execute by user ID when user exists and fetching basic profile fails throws error")
    func executeWhenFetchingBasicProfileByUserIDFailsThrowsError() async throws {
        let userID = try #require(UUID(uuidString: "12B46C87-AC38-43B5-B197-983BA2810EBC"))
        let userDTO = try Self.createUserDTO(id: userID)
        userService.fetchByIDResult = .success(userDTO)
        repository.fetchByUserIDResult = .failure(.unknown())

        await #expect(throws: FetchBasicProfileError.unknown()) {
            _ = try await useCase.execute(userID: userID)
        }
        #expect(userService.fetchByIDWasCalled)
        #expect(userService.lastFetchByIDID == userID)
        #expect(repository.fetchByUserIDWasCalled)
        #expect(repository.lastFetchByUserIDUserID == userID)
    }

}

extension FetchBasicProfileTests {

    private static func createUserDTO(
        id: UUID? = UUID(uuidString: "12B46C87-AC38-43B5-B197-983BA2810EBC"),
        firstName: String = "Dave",
        familyName: String = "Smith",
        fullName: String = "Dave Smith",
        email: String = "email@example.com"
    ) throws -> UserDTO {
        try UserDTO(
            id: #require(id),
            firstName: firstName,
            familyName: familyName,
            fullName: fullName,
            email: email
        )
    }

    private static func createBasicProfile(
        id: UUID? = UUID(uuidString: "51045953-FA7E-47FF-A336-D608742031DF"),
        userID: UUID? = UUID(uuidString: "12B46C87-AC38-43B5-B197-983BA2810EBC"),
        displayName: String = "Dave",
        birthDate: Date = Date(timeIntervalSince1970: 0)
    ) throws -> BasicProfile {
        try BasicProfile(
            id: #require(id),
            userID: #require(userID),
            displayName: displayName,
            birthDate: birthDate
        )
    }

}
