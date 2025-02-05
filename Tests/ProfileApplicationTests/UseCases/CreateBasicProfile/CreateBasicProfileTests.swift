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

    init() {
        self.repository = CreateBasicProfileStubRepository()
        self.useCase = CreateBasicProfile(repository: repository)
    }

    @Test("execute when basic profile created returns basic profile")
    func executeWhenBasicProfileCreatedReturnsBasicProfile() async throws {
        let input = try CreateBasicProfileInput(
            userID: #require(UUID(uuidString: "12B46C87-AC38-43B5-B197-983BA2810EBC")),
            displayName: "Dave",
            birthDate: Date(timeIntervalSince1970: 0)
        )
        let basicProfile = try BasicProfile(
            id: #require(UUID(uuidString: "33906175-5EBF-431F-9B4F-E5DAE513015C")),
            userID: #require(UUID(uuidString: "12B46C87-AC38-43B5-B197-983BA2810EBC")),
            displayName: "Dave",
            birthDate: Date(timeIntervalSince1970: 0)
        )

        repository.createResult = .success(basicProfile)

        let basicProfileDTO = try await useCase.execute(input: input)

        #expect(basicProfileDTO.id == basicProfile.id)
        #expect(repository.lastCreateInput == input)
    }

    @Test("execute when create basic profile fails throws error")
    func executeWhenCreatingBasicProfileFailsThrowsError() async throws {
        let input = try CreateBasicProfileInput(
            userID: #require(UUID(uuidString: "12B46C87-AC38-43B5-B197-983BA2810EBC")),
            displayName: "Dave",
            birthDate: Date(timeIntervalSince1970: 0)
        )
        repository.createResult = .failure(.unknown())

        await #expect(throws: CreateBasicProfileError.unknown()) {
            _ = try await useCase.execute(input: input)
        }
    }

}
