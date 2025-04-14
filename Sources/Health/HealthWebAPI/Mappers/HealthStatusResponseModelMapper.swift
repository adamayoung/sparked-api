//
//  HealthStatusResponseModelMapper.swift
//  SparkedAPI
//
//  Created by Adam Young on 14/03/2025.
//

import Foundation

struct HealthStatusResponseModelMapper {

    private init() {}

    static func map(from healthStatus: HealthStatus) -> HealthStatusResponseModel {
        let uptimeDuration: Duration = .seconds(healthStatus.uptime)

        return HealthStatusResponseModel(
            database: healthStatus.database,
            storage: healthStatus.storage,
            uptime: uptimeDuration.formatted(.time(pattern: .hourMinuteSecond))
        )
    }

}
