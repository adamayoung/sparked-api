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
        let userContext = UserContextStub.user
        let userID = try #require(userContext.userID)
        let input = try Self.createCreateBasicProfileInput(userID: userID)
        let user = User(id: userID, email: "some@email.com")

        repository.createResult = .success(Void())
        userRepository.fetchByIDResult = .success(user)

        _ = try await useCase.execute(input: input, userContext: userContext)

        #expect(repository.createWasCalled)
        #expect(repository.lastCreateBasicProfile?.ownerID == userID)
    }

    @Test("execute when create basic profile fails throws error")
    func executeWhenCreatingBasicProfileFailsThrowsError() async throws {
        let userContext = UserContextStub.user
        let userID = try #require(userContext.userID)
        let input = try Self.createCreateBasicProfileInput(userID: userID)
        let user = User(id: userID, email: "some@email.com")

        repository.createResult = .failure(.unknown())
        userRepository.fetchByIDResult = .success(user)

        await #expect(
            throws: CreateBasicProfileError.unknown(BasicProfileRepositoryError.unknown())
        ) {
            _ = try await useCase.execute(input: input, userContext: UserContextStub.user)
        }
        #expect(repository.createWasCalled)
        #expect(repository.lastCreateBasicProfile?.ownerID == input.ownerID)
    }

}

extension CreateBasicProfileTests {

    private static func createCreateBasicProfileInput(
        userID: UUID? = UUID(uuidString: "12B46C87-AC38-43B5-B197-983BA2810EBC"),
        displayName: String = "Dave Smith",
        birthDate: Date = Date(timeIntervalSince1970: 0),
        bio: String = ""
    ) throws -> CreateBasicProfileInput {
        try CreateBasicProfileInput(
            displayName: displayName,
            birthDate: birthDate,
            bio: bio,
            ownerID: #require(userID)
        )
    }

    private static func createBasicProfile(
        id: UUID? = UUID(uuidString: "51045953-FA7E-47FF-A336-D608742031DF"),
        userID: UUID? = UUID(uuidString: "12B46C87-AC38-43B5-B197-983BA2810EBC"),
        displayName: String = "Dave",
        birthDate: Date = Date(timeIntervalSince1970: 0),
        bio: String = ""
    ) throws -> BasicProfile {
        try BasicProfile(
            id: #require(id),
            displayName: displayName,
            birthDate: birthDate,
            bio: bio,
            ownerID: #require(userID)
        )
    }

}
