//
//  BasicProfileDefaultRepositoryTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 11/02/2025.
//

import Foundation
import ProfileApplication
import ProfileDomain
import Testing

@testable import ProfileInfrastructure

@Suite("BasicProfileDefaultRepository")
struct BasicProfileDefaultRepositoryTests {

    let repository: BasicProfileDefaultRepository
    let remoteDataSource: BasicProfileRemoteStubDataSource

    init() {
        self.remoteDataSource = BasicProfileRemoteStubDataSource()
        self.repository = BasicProfileDefaultRepository(remoteDataSource: remoteDataSource)
    }

    @Test("create creates basic profile")
    func createCreatesBasicProfile() async throws {
        let basicProfile = try Self.makeBasicProfile()
        remoteDataSource.createResult = .success(Void())

        try await repository.create(basicProfile)

        #expect(remoteDataSource.createWasCalled)
        #expect(remoteDataSource.lastCreateBasicProfile == basicProfile)
    }

    @Test("create when remote data source create fails throws error")
    func createWhenRemoteDataSourceCreatesFailsThrowsError() async throws {
        let basicProfile = try Self.makeBasicProfile()
        remoteDataSource.createResult = .failure(.unknown())

        await #expect(throws: BasicProfileRepositoryError.unknown()) {
            try await repository.create(basicProfile)
        }
        #expect(remoteDataSource.createWasCalled)
        #expect(remoteDataSource.lastCreateBasicProfile == basicProfile)
    }

    @Test("fetch by ID returns basic profile")
    func fetchByIDReturnsBasicProfile() async throws {
        let id = try #require(UUID(uuidString: "5D2B6829-603B-425F-B9FA-C890BC121335"))
        let expectedBasicProfile = try Self.makeBasicProfile(id: id)
        remoteDataSource.fetchByIDResult = .success(expectedBasicProfile)

        let basicProfile = try await repository.fetch(byID: id)

        #expect(basicProfile == expectedBasicProfile)
        #expect(remoteDataSource.fetchByIDWasCalled)
        #expect(remoteDataSource.lastFetchByIDID == id)
    }

    @Test("fetch by ID when remote data source fetch by ID fails throws error")
    func fetchByIDWhenRemoteDataSourceFetchByIDFailsThrowsError() async throws {
        let id = try #require(UUID(uuidString: "5D2B6829-603B-425F-B9FA-C890BC121335"))
        remoteDataSource.fetchByIDResult = .failure(.unknown())

        await #expect(throws: BasicProfileRepositoryError.self) {
            try await repository.fetch(byID: id)
        }
    }

    @Test("fetch by user ID returns basic profile")
    func fetchByUserIDReturnsBasicProfile() async throws {
        let userID = try #require(UUID(uuidString: "F6AA977F-D5E5-40FB-BC94-F6029B8084F2"))
        let expectedBasicProfile = try Self.makeBasicProfile(userID: userID)
        remoteDataSource.fetchByUserIDResult = .success(expectedBasicProfile)

        let basicProfile = try await repository.fetch(byUserID: userID)

        #expect(basicProfile == expectedBasicProfile)
        #expect(remoteDataSource.fetchByUserIDWasCalled)
        #expect(remoteDataSource.lastFetchByUserIDUserID == userID)
    }

    @Test("fetch by user ID when remote data source fetch by user ID fails throws error")
    func fetchByUserIDWhenRemoteDataSourceFetchByUserIDFailsThrowsError() async throws {
        let userID = try #require(UUID(uuidString: "F6AA977F-D5E5-40FB-BC94-F6029B8084F2"))
        remoteDataSource.fetchByUserIDResult = .failure(.unknown())

        await #expect(throws: BasicProfileRepositoryError.self) {
            try await repository.fetch(byUserID: userID)
        }
        #expect(remoteDataSource.fetchByUserIDWasCalled)
        #expect(remoteDataSource.lastFetchByUserIDUserID == userID)
    }

}

extension BasicProfileDefaultRepositoryTests {

    private static func makeBasicProfile(
        id: UUID? = UUID(uuidString: "B552E889-6409-40F1-BFA2-7CD40A26CF41"),
        userID: UUID? = UUID(uuidString: "BC925225-56C9-4BD1-AC64-BB890279F489"),
        displayName: String = "Display Name",
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
