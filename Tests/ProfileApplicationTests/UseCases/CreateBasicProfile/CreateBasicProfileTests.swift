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
        let userContext = UserMockContext.withUserRoleMock()
        let userID = try #require(userContext.userID)
        let input = try CreateBasicProfileInput.mock(userID: userID)
        let user = try User.mock(id: userID)

        repository.createResult = .success(Void())
        userRepository.fetchByIDResult = .success(user)

        _ = try await useCase.execute(input: input, userContext: userContext)

        #expect(repository.createWasCalled)
        #expect(repository.lastCreateBasicProfile?.ownerID == userID)
    }

    @Test("execute when create basic profile fails throws error")
    func executeWhenCreatingBasicProfileFailsThrowsError() async throws {
        let userContext = UserMockContext.withUserRoleMock()
        let userID = try #require(userContext.userID)
        let input = try CreateBasicProfileInput.mock(userID: userID)
        let user = User(id: userID, email: "some@email.com")

        repository.createResult = .failure(.unknown())
        userRepository.fetchByIDResult = .success(user)

        await #expect(
            throws: CreateBasicProfileError.unknown(BasicProfileRepositoryError.unknown())
        ) {
            _ = try await useCase.execute(input: input, userContext: userContext)
        }
        #expect(repository.createWasCalled)
        #expect(repository.lastCreateBasicProfile?.ownerID == input.ownerID)
    }

}
