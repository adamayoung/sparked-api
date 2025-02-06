//
//  CountryControllerTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 06/02/2025.
//

import APITesting
import Foundation
import ReferenceDataApplication
import Testing

@testable import ReferenceDataPresentation

@Suite("CountryController", .serialized)
struct CountryControllerTests {

    let controller: CountryController
    let fetchCountriesUseCase: FetchCountriesStubUseCase

    init() throws {
        self.fetchCountriesUseCase = FetchCountriesStubUseCase()
        let dependencies = CountryController.Dependencies(
            fetchCountriesUseCase: { [fetchCountriesUseCase] in fetchCountriesUseCase }
        )
        self.controller = CountryController(dependencies: dependencies)
    }

    @Test("index returns countries")
    func indexReturnsCountries() async throws {
        let countriesDTOs = try [
            CountryDTO(
                id: #require(UUID(uuidString: "C7DDD5D2-E7B4-424E-9460-D0CD7F0057F4")),
                code: "GB",
                name: "United Kingdom"
            ),
            CountryDTO(
                id: #require(UUID(uuidString: "81B1F44D-A552-48A4-9AE9-22B83C5292EA")),
                code: "US",
                name: "United States"
            )
        ]
        let expectedResponseModels = try [
            CountryResponseModel(
                id: #require(UUID(uuidString: "C7DDD5D2-E7B4-424E-9460-D0CD7F0057F4")),
                code: "GB",
                name: "United Kingdom"
            ),
            CountryResponseModel(
                id: #require(UUID(uuidString: "81B1F44D-A552-48A4-9AE9-22B83C5292EA")),
                code: "US",
                name: "United States"
            )
        ]
        fetchCountriesUseCase.executeResult = .success(countriesDTOs)

        try await testWithApp(controller) { app in
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
