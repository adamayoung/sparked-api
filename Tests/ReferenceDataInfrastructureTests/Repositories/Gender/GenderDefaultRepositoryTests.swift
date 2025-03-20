//
//  GenderDefaultRepositoryTests.swift
//  SparkedAPI
//
//  Created by Adam Young on 06/02/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain
import Testing

@testable import ReferenceDataInfrastructure

@Suite("GenderDefaultRepository")
struct GenderDefaultRepositoryTests {

    let repository: GenderDefaultRepository
    let remoteDataSource: GenderRemoteStubDataSource
    let cacheDataSource: GenderCacheStubDataSource

    init() {
        self.remoteDataSource = GenderRemoteStubDataSource()
        self.cacheDataSource = GenderCacheStubDataSource()
        self.repository = GenderDefaultRepository(
            remoteDataSource: self.remoteDataSource,
            cacheDataSource: self.cacheDataSource
        )
    }

    @Test("genders returns genders")
    func gendersReturnsCountries() async throws {
        let expectedGenders: [Gender] = try [.maleMock(), .femaleMock()]
        remoteDataSource.fetchAllResult = .success(expectedGenders)

        let genders = try await repository.fetchAll()

        #expect(genders == expectedGenders)
        #expect(remoteDataSource.fetchAllWasCalled)
    }

    @Test("genders when fails throws error")
    func gendersWhenFailsThrowsError() async throws {
        remoteDataSource.fetchAllResult = .failure(.unknown())

        await #expect(throws: GenderRepositoryError.unknown()) {
            try await repository.fetchAll()
        }
        #expect(remoteDataSource.fetchAllWasCalled)
    }

}
