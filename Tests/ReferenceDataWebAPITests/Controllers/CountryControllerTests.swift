//
//  CountryControllerTests.swift
//  SparkedAPI
//
//  Created by Adam Young on 06/02/2025.
//

import APITesting
import Foundation
import ReferenceDataApplication
import Testing

@testable import ReferenceDataWebAPI

@Suite("CountryController", .serialized)
struct CountryControllerTests {

    let controller: CountryController
    let fetchCountriesUseCase: FetchCountriesStubUseCase
    let fetchCountryUseCase: FetchCountryStubUseCase

    init() throws {
        self.fetchCountriesUseCase = FetchCountriesStubUseCase()
        self.fetchCountryUseCase = FetchCountryStubUseCase()
        self.controller = CountryController()
    }

    @Test("index returns countries")
    func indexReturnsCountries() async throws {
        let countriesDTOs = try [
            CountryDTO(
                id: #require(UUID(uuidString: "C7DDD5D2-E7B4-424E-9460-D0CD7F0057F4")),
                code: "GB",
                name: "United Kingdom",
                nameKey: "UNITED_KINGDOM"
            ),
            CountryDTO(
                id: #require(UUID(uuidString: "81B1F44D-A552-48A4-9AE9-22B83C5292EA")),
                code: "US",
                name: "United States",
                nameKey: "UNITED_STATES"
            )
        ]
        let expectedResponseModels = try [
            CountryResponseModel(
                id: #require(UUID(uuidString: "C7DDD5D2-E7B4-424E-9460-D0CD7F0057F4")),
                code: "GB",
                name: "United Kingdom",
                nameKey: "UNITED_KINGDOM"
            ),
            CountryResponseModel(
                id: #require(UUID(uuidString: "81B1F44D-A552-48A4-9AE9-22B83C5292EA")),
                code: "US",
                name: "United States",
                nameKey: "UNITED_STATES"
            )
        ]
        fetchCountriesUseCase.executeResult = .success(countriesDTOs)

        try await testWithApp(controller) { app in
            app.referenceDataWebAPIUseCases.use { _ in fetchCountriesUseCase }

            try await app.testing().test(
                .GET, "countries",
                afterResponse: { res async throws in
                    #expect(res.status == .ok)
                    let responseModels = try res.content.decode([CountryResponseModel].self)
                    #expect(responseModels == expectedResponseModels)
                    #expect(fetchCountriesUseCase.executeCalled)
                }
            )
        }
    }

    @Test("index when fetch fails throws error")
    func indexWhenFetchFailsThrowsError() async throws {
        fetchCountriesUseCase.executeResult = .failure(.unknown())

        try await testWithApp(controller) { app in
            app.referenceDataWebAPIUseCases.use { _ in fetchCountriesUseCase }

            try await app.testing().test(
                .GET, "countries",
                afterResponse: { res async throws in
                    #expect(res.status == .internalServerError)
                    #expect(fetchCountriesUseCase.executeCalled)
                }
            )
        }
    }

}
