//
//  BasicInfoDefaultRepositoryTests.swift
//  SparkedAPI
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
        let basicInfo = try BasicInfo.mock()
        remoteDataSource.createResult = .success(Void())

        try await repository.create(basicInfo)

        #expect(remoteDataSource.createWasCalled)
        #expect(remoteDataSource.lastCreateBasicInfo == basicInfo)
    }

    @Test("create when remote data source create fails throws error")
    func createWhenRemoteDataSourceCreatesFailsThrowsError() async throws {
        let basicInfo = try BasicInfo.mock()
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
        let expectedBasicInfo = try BasicInfo.mock(id: profileID)
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
