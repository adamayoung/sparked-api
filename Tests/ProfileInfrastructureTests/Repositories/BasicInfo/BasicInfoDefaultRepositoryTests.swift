//
//  BasicInfoDefaultRepositoryTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 11/02/2025.
//

import Foundation
import ProfileApplication
import ProfileDomain
import Testing

@testable import ProfileInfrastructure

@Suite("BasicInfoDefaultRepository")
struct BasicInfoDefaultRepositoryTests {

    let repository: BasicInfoDefaultRepository
    let remoteDataSource: BasicInfoRemoteStubDataSource

    init() {
        self.remoteDataSource = BasicInfoRemoteStubDataSource()
        self.repository = BasicInfoDefaultRepository(remoteDataSource: remoteDataSource)
    }

    @Test("create creates basic info")
    func createCreatesBasicInfo() async throws {
        let basicInfo = try Self.makeBasicInfo()

        remoteDataSource.createResult = .success(Void())

        try await repository.create(basicInfo)

        #expect(remoteDataSource.createWasCalled)
        #expect(remoteDataSource.lastCreateBasicInfo == basicInfo)
    }

    @Test("create when remote data source create fails throws error")
    func createWhenRemoteDataSourceCreatesFailsThrowsError() async throws {
        let basicInfo = try Self.makeBasicInfo()
        remoteDataSource.createResult = .failure(.unknown())

        await #expect(throws: BasicInfoRepositoryError.unknown()) {
            try await repository.create(basicInfo)
        }
        #expect(remoteDataSource.createWasCalled)
        #expect(remoteDataSource.lastCreateBasicInfo == basicInfo)
    }

    @Test("fetch by profile ID returns basic info")
    func fetchByProfileIDReturnsBasicInfo() async throws {
        let profileID = try #require(UUID(uuidString: "F851F836-1B2A-42F7-8298-F6431FA5E246"))
        let expectedBasicInfo = try Self.makeBasicInfo(id: profileID)
        remoteDataSource.fetchByProfileIDResult = .success(expectedBasicInfo)

        let basicInfo = try await repository.fetch(byProfileID: profileID)

        #expect(basicInfo == expectedBasicInfo)
        #expect(remoteDataSource.fetchByProfileIDWasCalled)
    }

    @Test("fetch by profile ID when remote data source fails throws error")
    func fetchByProfileIDWhenRemoteDataSourceFailsThrowsError() async throws {
        let profileID = try #require(UUID(uuidString: "F851F836-1B2A-42F7-8298-F6431FA5E246"))
        remoteDataSource.fetchByProfileIDResult = .failure(.unknown())

        await #expect(throws: BasicInfoRepositoryError.unknown()) {
            try await repository.fetch(byProfileID: profileID)
        }
    }

}

extension BasicInfoDefaultRepositoryTests {

    private static func makeBasicInfo(
        id: UUID? = UUID(uuidString: "F851F836-1B2A-42F7-8298-F6431FA5E246"),
        profileID: UUID? = UUID(uuidString: "AF009805-B95B-4676-9307-A47FD8FFDEF7"),
        genderID: UUID? = UUID(uuidString: "274CB99E-E95C-46FA-95B4-DFFCD9D81EAC"),
        countryID: UUID? = UUID(uuidString: "7CB0462C-B977-4B3F-B0E3-A02137C977E0"),
        location: String = "Location",
        homeTown: String? = "Home town",
        workplace: String? = "Workplace",
        ownerID: UUID? = UUID(uuidString: "E5DD4113-B75D-422B-BA88-1781E0A0858E")
    ) throws -> BasicInfo {
        try BasicInfo(
            id: #require(id),
            profileID: #require(profileID),
            genderID: #require(genderID),
            countryID: #require(countryID),
            location: location,
            homeTown: homeTown,
            workplace: workplace,
            ownerID: #require(ownerID)
        )
    }

}
