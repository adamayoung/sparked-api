//
//  GenderDefaultRepositoryTests.swift
//  AdamDateApp
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

    init() {
        self.remoteDataSource = GenderRemoteStubDataSource()
        self.repository = GenderDefaultRepository(
            remoteDataSource: self.remoteDataSource
        )
    }

    @Test("genders returns genders")
    func gendersReturnsCountries() async throws {
        let expectedCountries = try [
            Gender(
                id: #require(UUID(uuidString: "76A6BA42-A862-40C5-B917-38F41CE13486")),
                code: "M",
                name: "Male"
            ),
            Gender(
                id: #require(UUID(uuidString: "A964D9DD-5FCA-4B87-9383-4033A26D0900")),
                code: "F",
                name: "Female"
            )
        ]
        remoteDataSource.fetchAllResult = .success(expectedCountries)

        let genders = try await repository.fetchAll()

        #expect(genders == expectedCountries)
        #expect(remoteDataSource.fetchAllWasCalled)
    }

    @Test("genders when fails throws error")
    func gendersWhenFailsThrowsError() async throws {
        remoteDataSource.fetchAllResult = .failure(.unknown())

        await #expect(throws: FetchGendersError.unknown()) {
            try await repository.fetchAll()
        }
        #expect(remoteDataSource.fetchAllWasCalled)
    }

}
