//
//  HealthControllerTests.swift
//  SparkedAPI
//
//  Created by Adam Young on 14/03/2025.
//

import APITesting
import Foundation
import Testing
import VaporTesting

@testable import HealthWebAPI

@Suite("Health Controller", .serialized)
struct HealthControllerTests {

    let controller: HealthController
    let healthService: HealthStubService

    init() throws {
        self.healthService = HealthStubService()
        self.controller = HealthController()
    }

    @Test("index when database and file storage are healthy returns ok")
    func indexWhenDatabaseAndFileStorageAreHealthyReturnsOk() async throws {
        healthService.statusResult = HealthStatus(database: true, storage: true, uptime: 0)

        try await testWithApp(controller) { app in
            app.healthServices.use { _ in healthService }

            try await app.testing().test(
                .GET, "",
                afterResponse: { res async in
                    #expect(res.status == .ok)
                    #expect(healthService.statusWasCalled)
                }
            )
        }
    }

    @Test(
        "index when database is not healthy and file storage is healthy returns internal server error"
    )
    func indexWhenDatabaseIsNotHealthyAndFileStorageIsHealthyReturnsInternalServerError()
        async throws
    {
        healthService.statusResult = HealthStatus(database: false, storage: true, uptime: 0)

        try await testWithApp(controller) { app in
            app.healthServices.use { _ in healthService }

            try await app.testing().test(
                .GET, "",
                afterResponse: { res async in
                    #expect(res.status == .internalServerError)
                    #expect(healthService.statusWasCalled)
                }
            )
        }
    }

    @Test(
        "index when database is healthy and file storage is not healthy returns internal server error"
    )
    func indexWhenDatabaseIsHealthyAndFileStorageIsNotHealthyReturnsInternalServerError()
        async throws
    {
        healthService.statusResult = HealthStatus(database: true, storage: false, uptime: 0)

        try await testWithApp(controller) { app in
            app.healthServices.use { _ in healthService }

            try await app.testing().test(
                .GET, "",
                afterResponse: { res async in
                    #expect(res.status == .internalServerError)
                    #expect(healthService.statusWasCalled)
                }
            )
        }
    }

    @Test("index when database and file storage is not healthy returns internal server error")
    func indexWhenDatabaseAndFileStorageIsNotHealthyReturnsInternalServerError() async throws {
        healthService.statusResult = HealthStatus(database: false, storage: false, uptime: 0)

        try await testWithApp(controller) { app in
            app.healthServices.use { _ in healthService }

            try await app.testing().test(
                .GET, "",
                afterResponse: { res async in
                    #expect(res.status == .internalServerError)
                    #expect(healthService.statusWasCalled)
                }
            )
        }
    }

}
