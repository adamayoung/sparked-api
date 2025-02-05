//
//  CreateBasicProfileTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 30/01/2025.
//

import Foundation
import ProfileDomain
import Testing

@testable import ProfileApplication

@Suite("CreateBasicProfile")
struct CreateBasicProfileTests {

    let useCase: CreateBasicProfile
    let repository: CreateBasicProfileStubRepository
    let userService: UserStubService

    init() {
        self.repository = CreateBasicProfileStubRepository()
        self.userService = UserStubService()
        self.useCase = CreateBasicProfile(repository: repository, userService: userService)
    }

    @Test("execute when user exists and basic profile created returns basic profile")
    func executeWhenUserExistsAndBasicProfileCreatedReturnsBasicProfile() async throws {
        let userID = try #require(UUID(uuidString: "12B46C87-AC38-43B5-B197-983BA2810EBC"))
        let input = try Self.createCreateBasicProfileInput(userID: userID)
        let userDTO = try Self.createUserDTO(id: userID)
        let basicProfile = try Self.createBasicProfile(userID: userID)

        userService.fetchByIDResult = .success(userDTO)
        repository.createResult = .success(basicProfile)

        let basicProfileDTO = try await useCase.execute(input: input)

        #expect(basicProfileDTO.id == basicProfile.id)
        #expect(userService.fetchByIDWasCalled)
        #expect(userService.lastFetchByIDID == userID)
        #expect(repository.createWasCalled)
        #expect(repository.lastCreateInput == input)
    }

    @Test("execute when user does not exist throws user not found error")
    func executeWhenUserDoesNotExistThrowsUserNotFoundError() async throws {
        let userID = try #require(UUID(uuidString: "12B46C87-AC38-43B5-B197-983BA2810EBC"))
        let input = try Self.createCreateBasicProfileInput(userID: userID)

        userService.fetchByIDResult = .failure(.notFound)

        await #expect(throws: CreateBasicProfileError.userNotFound(userID: userID)) {
            _ = try await useCase.execute(input: input)
        }
        #expect(userService.fetchByIDWasCalled)
        #expect(userService.lastFetchByIDID == userID)
        #expect(!repository.createWasCalled)
    }

    @Test("execute when create basic profile fails throws error")
    func executeWhenCreatingBasicProfileFailsThrowsError() async throws {
        let userID = try #require(UUID(uuidString: "12B46C87-AC38-43B5-B197-983BA2810EBC"))
        let input = try Self.createCreateBasicProfileInput(userID: userID)
        let userDTO = try Self.createUserDTO(id: userID)

        userService.fetchByIDResult = .success(userDTO)
        repository.createResult = .failure(.unknown())

        await #expect(throws: CreateBasicProfileError.unknown()) {
            _ = try await useCase.execute(input: input)
        }
        #expect(userService.fetchByIDWasCalled)
        #expect(userService.lastFetchByIDID == userID)
        #expect(repository.createWasCalled)
        #expect(repository.lastCreateInput == input)
    }

}

extension CreateBasicProfileTests {

    private static func createCreateBasicProfileInput(
        userID: UUID? = UUID(uuidString: "12B46C87-AC38-43B5-B197-983BA2810EBC"),
        displayName: String = "Dave Smith",
        birthDate: Date = Date(timeIntervalSince1970: 0)
    ) throws -> CreateBasicProfileInput {
        try CreateBasicProfileInput(
            userID: #require(userID),
            displayName: displayName,
            birthDate: birthDate
        )
    }

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
