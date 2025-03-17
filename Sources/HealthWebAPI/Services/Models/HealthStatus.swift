//
//  HealthStatus.swift
//  AdamDateApp
//
//  Created by Adam Young on 14/03/2025.
//

import Foundation

package struct HealthStatus: Equatable, Sendable {

    package let database: Bool
    package let storage: Bool
    package let uptime: TimeInterval

    package var isHealthy: Bool {
        database && storage
    }

    package init(
        database: Bool,
        storage: Bool,
        uptime: TimeInterval
    ) {
        self.database = database
        self.storage = storage
        self.uptime = uptime
    }

}
