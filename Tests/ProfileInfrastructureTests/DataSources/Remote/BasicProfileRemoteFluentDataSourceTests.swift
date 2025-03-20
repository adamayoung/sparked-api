//
//  BasicProfileRemoteFluentDataSourceTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 30/01/2025.
//

import Fluent
import Foundation
import ProfileApplication
import ProfileDomain
import Testing
import XCTFluent

@testable import ProfileInfrastructure

@Suite("BasicProfileRemoteFluentDataSource")
struct BasicProfileRemoteFluentDataSourceTests {

    let dataSource: BasicProfileRemoteFluentDataSource
    let database: ArrayTestDatabase

    init() {
        self.database = ArrayTestDatabase()
        self.dataSource = BasicProfileRemoteFluentDataSource(database: database.db)
    }

    @Test("create when profile does not exist for user creates profile")
    func createWhenProfileDoesNotExistForUserCreatesProfile() async throws {
        let id = try #require(UUID(uuidString: "D74A08FC-0248-42AC-8DF9-759B6CEF8165"))
        let userID = try #require(UUID(uuidString: "9991A3C9-29AB-4C0F-90BD-51782083F344"))
        let basicProfile = BasicProfile(
            id: id,
            displayName: "Dave",
            birthDate: Date(timeIntervalSince1970: 10000),
            bio: "Bio",
            ownerID: userID
        )
        database.append([])
        database.append([TestOutput()])

        await #expect(throws: Never.self) {
            try await dataSource.create(basicProfile)
        }
    }

    @Test("create when profile does exist for user throws profile already exists for user error")
    func createWhenProfileDoesExistForUserThrowsProfileAlreadyExistsForUserError() async throws {
        let userID = try #require(UUID(uuidString: "9991A3C9-29AB-4C0F-90BD-51782083F344"))
        let existingBasicProfile = try BasicProfileModel.mock(
            id: UUID(uuidString: "E00F5F37-00B8-4EEE-95F5-ADEC2BA9A9A4"),
            ownerID: userID
        )
        let basicProfile = try BasicProfile.mock(
            id: try #require(UUID(uuidString: "9CABF8F2-24C8-43E5-AFFF-D9CBAB3F06FA")),
            ownerID: userID
        )
        database.append([existingBasicProfile])
        database.append([TestOutput()])

        await #expect(throws: BasicProfileRepositoryError.duplicate) {
            try await dataSource.create(basicProfile)
        }
    }

    @Test("fetch by ID when profile exists returns profile")
    func fetchByIDWhenProfileExistsReturnsProfile() async throws {
        let id = try #require(UUID(uuidString: "42E8A178-B848-4558-946E-BBE007527110"))
        let existingBasicProfile = try BasicProfileModel.mock(id: id)
        database.append([existingBasicProfile])

        let basicProfile = try await dataSource.fetch(byID: id)

        #expect(basicProfile.id == id)
    }

    @Test("fetch by ID when profile does not exists throws not found error")
    func fetchByIDWhenProfileDoesNotExistsThrowsNotFoundError() async throws {
        let id = try #require(UUID(uuidString: "42E8A178-B848-4558-946E-BBE007527110"))
        database.append([])

        await #expect(throws: BasicProfileRepositoryError.notFound) {
            _ = try await dataSource.fetch(byID: id)
        }
    }

    @Test("fetch by user ID when profile exists returns profile")
    func fetchByUserIDWhenProfileExistsReturnsProfile() async throws {
        let userID = try #require(UUID(uuidString: "FAB7120C-EF53-4FDC-94DE-A64489DB39B5"))
        let existingBasicProfile = try BasicProfileModel.mock(ownerID: userID)
        database.append([existingBasicProfile])

        let basicProfile = try await dataSource.fetch(byUserID: userID)

        #expect(basicProfile.ownerID == userID)
    }

    @Test("fetch by user ID when profile does not exists throws user not found error")
    func fetchByUserIDWhenProfileDoesNotExistsThrowsNotFoundError() async throws {
        let userID = try #require(UUID(uuidString: "FAB7120C-EF53-4FDC-94DE-A64489DB39B5"))
        database.append([])

        await #expect(throws: BasicProfileRepositoryError.notFound) {
            _ = try await dataSource.fetch(byUserID: userID)
        }
    }

}
