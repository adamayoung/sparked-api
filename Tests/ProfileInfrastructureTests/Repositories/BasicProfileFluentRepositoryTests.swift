//
//  BasicProfileFluentRepositoryTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 30/01/2025.
//

import Fluent
import Foundation
import ProfileDomain
import Testing
import XCTFluent

@testable import ProfileInfrastructure

@Suite("BasicProfileFluentRepository")
struct BasicProfileFluentRepositoryTests {

    let repository: BasicProfileFluentRepository
    let database: ArrayTestDatabase

    init() {
        self.database = ArrayTestDatabase()
        self.repository = BasicProfileFluentRepository(database: database.db)
    }

    @Test("create when profile does not exist for user creates profile")
    func createWhenProfileDoesNotExistForUserCreatesProfile() async throws {
        let userID = try #require(UUID(uuidString: "9991A3C9-29AB-4C0F-90BD-51782083F344"))
        let input = CreateBasicProfileInput(
            userID: userID,
            displayName: "Dave",
            birthDate: Date(timeIntervalSince1970: 10000)
        )
        database.append([])
        database.append([TestOutput()])

        let basicProfile = try await repository.create(input: input)

        #expect(basicProfile.userID == userID)
    }

    @Test("create when profile does exist for user throws profile already exists for user error")
    func createWhenProfileDoesExistForUserThrowsProfileAlreadyExistsForUserError() async throws {
        let userID = try #require(UUID(uuidString: "9991A3C9-29AB-4C0F-90BD-51782083F344"))
        let existingBasicProfile = BasicProfileModel(
            id: UUID(uuidString: "E00F5F37-00B8-4EEE-95F5-ADEC2BA9A9A4"),
            userID: userID,
            displayName: "Dave",
            birthDate: Date(timeIntervalSince1970: 10000)
        )
        let input = CreateBasicProfileInput(
            userID: userID,
            displayName: "Dave",
            birthDate: Date(timeIntervalSince1970: 10000)
        )
        database.append([existingBasicProfile])
        database.append([TestOutput()])

        await #expect(throws: CreateBasicProfileError.profileAlreadyExistsForUser(userID: userID)) {
            _ = try await repository.create(input: input)
        }
    }

    @Test("fetch by ID when profile exists returns profile")
    func fetchByIDWhenProfileExistsReturnsProfile() async throws {
        let id = try #require(UUID(uuidString: "42E8A178-B848-4558-946E-BBE007527110"))
        let existingBasicProfile = try BasicProfileModel(
            id: id,
            userID: #require(UUID(uuidString: "FAB7120C-EF53-4FDC-94DE-A64489DB39B5")),
            displayName: "Dave",
            birthDate: Date(timeIntervalSince1970: 10000)
        )
        database.append([existingBasicProfile])

        let basicProfile = try await repository.fetch(byID: id)

        #expect(basicProfile.id == id)
    }

    @Test("fetch by ID when profile does not exists throws not found error")
    func fetchByIDWhenProfileDoesNotExistsThrowsNotFoundError() async throws {
        let id = try #require(UUID(uuidString: "42E8A178-B848-4558-946E-BBE007527110"))
        database.append([])

        await #expect(throws: FetchBasicProfileError.notFound(profileID: id)) {
            _ = try await repository.fetch(byID: id)
        }
    }

    @Test("fetch by user ID when profile exists returns profile")
    func fetchByUserIDWhenProfileExistsReturnsProfile() async throws {
        let userID = try #require(UUID(uuidString: "FAB7120C-EF53-4FDC-94DE-A64489DB39B5"))
        let existingBasicProfile = try BasicProfileModel(
            id: #require(UUID(uuidString: "42E8A178-B848-4558-946E-BBE007527110")),
            userID: userID,
            displayName: "Dave",
            birthDate: Date(timeIntervalSince1970: 10000)
        )
        database.append([existingBasicProfile])

        let basicProfile = try await repository.fetch(byUserID: userID)

        #expect(basicProfile.userID == userID)
    }

    @Test("fetch by user ID when profile does not exists throws user not found error")
    func fetchByUserIDWhenProfileDoesNotExistsThrowsNotFoundError() async throws {
        let userID = try #require(UUID(uuidString: "FAB7120C-EF53-4FDC-94DE-A64489DB39B5"))
        database.append([])

        await #expect(throws: FetchBasicProfileError.userNotFound(userID: userID)) {
            _ = try await repository.fetch(byUserID: userID)
        }
    }

}
