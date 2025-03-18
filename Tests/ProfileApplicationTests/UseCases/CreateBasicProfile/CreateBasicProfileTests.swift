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
    let repository: BasicProfileStubRepository
    let userRepository: UserStubRepository

    init() {
        self.repository = BasicProfileStubRepository()
        self.userRepository = UserStubRepository()
        self.useCase = CreateBasicProfile(
            repository: repository,
            userRepository: userRepository
        )
    }

    @Test("execute when user exists and basic profile created returns basic profile")
    func executeWhenUserExistsAndBasicProfileCreatedReturnsBasicProfile() async throws {
        let userID = try #require(UUID(uuidString: "12B46C87-AC38-43B5-B197-983BA2810EBC"))
        let input = try Self.createCreateBasicProfileInput(userID: userID)
        let basicProfile = try Self.createBasicProfile(userID: userID)
        let user = User(id: userID, email: "some@email.com")

        repository.createResult = .success(Void())
        userRepository.fetchByIDResult = .success(user)

        let basicProfileDTO = try await useCase.execute(input: input)

        #expect(basicProfileDTO.userID == basicProfile.userID)
        #expect(repository.createWasCalled)
        #expect(repository.lastCreateBasicProfile?.userID == userID)
    }

    @Test("execute when create basic profile fails throws error")
    func executeWhenCreatingBasicProfileFailsThrowsError() async throws {
        let userID = try #require(UUID(uuidString: "12B46C87-AC38-43B5-B197-983BA2810EBC"))
        let input = try Self.createCreateBasicProfileInput(userID: userID)
        let user = User(id: userID, email: "some@email.com")

        repository.createResult = .failure(.unknown())
        userRepository.fetchByIDResult = .success(user)

        await #expect(
            throws: CreateBasicProfileError.unknown(BasicProfileRepositoryError.unknown())
        ) {
            _ = try await useCase.execute(input: input)
        }
        #expect(repository.createWasCalled)
        #expect(repository.lastCreateBasicProfile?.userID == input.userID)
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
