//
//  CountryDefaultRepositoryTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 06/02/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain
import Testing

@testable import ReferenceDataInfrastructure

@Suite("CountryDefaultRepository")
struct CountryDefaultRepositoryTests {

    let repository: CountryDefaultRepository
    let remoteDataSource: CountryRemoteStubDataSource
    let cacheDataSource: CountryCacheStubDataSource

    init() {
        self.remoteDataSource = CountryRemoteStubDataSource()
        self.cacheDataSource = CountryCacheStubDataSource()
        self.repository = CountryDefaultRepository(
            remoteDataSource: self.remoteDataSource,
            cacheDataSource: self.cacheDataSource
        )
    }

    @Test("countries returns countries")
    func countriesReturnsCountries() async throws {
        let expectedCountries: [Country] = try [.unitedStatesMock(), .unitedKingdomMock()]
        remoteDataSource.fetchAllResult = .success(expectedCountries)

        let countries = try await repository.fetchAll()

        #expect(countries == expectedCountries)
        #expect(remoteDataSource.fetchAllWasCalled)
    }

    @Test("countries when fails throws error")
    func countriesWhenFailsThrowsError() async throws {
        remoteDataSource.fetchAllResult = .failure(.unknown())

        await #expect(throws: CountryRepositoryError.unknown()) {
            try await repository.fetchAll()
        }
        #expect(remoteDataSource.fetchAllWasCalled)
    }

}
