//
//  GenderControllerTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 06/02/2025.
//

import APITesting
import Foundation
import ReferenceDataApplication
import Testing

@testable import ReferenceDataPresentation

@Suite("GenderController", .serialized)
struct GenderControllerTests {

    let controller: GenderController
    let fetchGendersUseCase: FetchGendersStubUseCase
    let fetchGenderUseCase: FetchGenderStubUseCase

    init() throws {
        self.fetchGendersUseCase = FetchGendersStubUseCase()
        self.fetchGenderUseCase = FetchGenderStubUseCase()
        let dependencies = GenderController.Dependencies(
            fetchGendersUseCase: { [fetchGendersUseCase] in fetchGendersUseCase },
            fetchGenderUseCase: { [fetchGenderUseCase] in fetchGenderUseCase }
        )
        self.controller = GenderController(dependencies: dependencies)
    }

    @Test("index returns countries")
    func indexReturnsGenders() async throws {
        let countriesDTOs = try [
            GenderDTO(
                id: #require(UUID(uuidString: "C7DDD5D2-E7B4-424E-9460-D0CD7F0057F4")),
                code: "M",
                name: "Male"
            ),
            GenderDTO(
                id: #require(UUID(uuidString: "81B1F44D-A552-48A4-9AE9-22B83C5292EA")),
                code: "F",
                name: "Female"
            )
        ]
        let expectedResponseModels = try [
            GenderResponseModel(
                id: #require(UUID(uuidString: "C7DDD5D2-E7B4-424E-9460-D0CD7F0057F4")),
                code: "M",
                name: "Male"
            ),
            GenderResponseModel(
                id: #require(UUID(uuidString: "81B1F44D-A552-48A4-9AE9-22B83C5292EA")),
                code: "F",
                name: "Female"
            )
        ]
        fetchGendersUseCase.executeResult = .success(countriesDTOs)

        try await testWithApp(controller) { app in
            try await app.testing().test(
                .GET, "genders",
                afterResponse: { res async throws in
                    #expect(res.status == .ok)
                    let responseModels = try res.content.decode([GenderResponseModel].self)
                    #expect(responseModels == expectedResponseModels)
                    #expect(fetchGendersUseCase.executeCalled)
                }
            )
        }
    }

    @Test("index when fetch fails throws error")
    func indexWhenFetchFailsThrowsError() async throws {
        fetchGendersUseCase.executeResult = .failure(.unknown())

        try await testWithApp(controller) { app in
            try await app.testing().test(
                .GET, "genders",
                afterResponse: { res async throws in
                    #expect(res.status == .internalServerError)
                    #expect(fetchGendersUseCase.executeCalled)
                }
            )
        }
    }

}
