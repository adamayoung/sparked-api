//
//  HealthServiceAdapter.swift
//  AdamDateApp
//
//  Created by Adam Young on 14/03/2025.
//

import FileStorageKit
import Fluent
import FluentSQL
import Foundation
import HealthWebAPI

final class HealthServiceAdapter: HealthService {

    private let database: any Database
    private let fileStorage: any FileStorage

    init(
        database: some Database,
        fileStorage: some FileStorage
    ) {
        self.database = database
        self.fileStorage = fileStorage
    }

    func status() async -> HealthStatus {
        let databaseStatus = await databaseStatus()
        let fileStorageStatus = await fileStorage.healthCheck()

        return HealthStatus(
            database: databaseStatus,
            storage: fileStorageStatus,
            uptime: ProcessInfo.processInfo.systemUptime
        )
    }

}

extension HealthServiceAdapter {

    private func databaseStatus() async -> Bool {
        guard let database = database as? SQLDatabase else {
            return false
        }

        do {
            _ = try await database.raw("SELECT COUNT(id) from _fluent_migrations").all()
            return true
        } catch {
            return false
        }
    }

}
