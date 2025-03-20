//
//  HealthStatusTests.swift
//  SparkedAPI
//
//  Created by Adam Young on 14/03/2025.
//

import Foundation
import HealthWebAPI
import Testing

@Suite("Health Status")
struct HealthStatusTests {

    @Test("isHealthy when database and storage is healthy returns true")
    func isHealthyWhenDatabaseAndStorageIsHealthyReturnsTrue() {
        let status = HealthStatus(database: true, storage: true, uptime: 0)

        #expect(status.isHealthy)
    }

    @Test("isHealthy when database is not healthy and storage is healthy returns false")
    func isHealthyWhenDatabaseIsNotHealthyAndStorageIsHealthyReturnsFalse() {
        let status = HealthStatus(database: false, storage: true, uptime: 0)

        #expect(!status.isHealthy)
    }

    @Test("isHealthy when database is healthy and storage is not healthy returns false")
    func isHealthyWhenDatabaseIsHealthyAndStorageIsNotHealthyReturnsFalse() {
        let status = HealthStatus(database: true, storage: false, uptime: 0)

        #expect(!status.isHealthy)
    }

    @Test("isHealthy when database and storage is not healthy returns false")
    func isHealthyWhenDatabaseAndStorageIsNotHealthyReturnsFalse() {
        let status = HealthStatus(database: false, storage: false, uptime: 0)

        #expect(!status.isHealthy)
    }

}
