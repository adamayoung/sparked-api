//
//  HealthStubServices.swift
//  SparkedAPI
//
//  Created by Adam Young on 14/03/2025.
//

import Foundation
import HealthWebAPI

final class HealthStubService: HealthService, @unchecked Sendable {

    var statusResult: HealthStatus?
    private(set) var statusWasCalled = false

    init() {}

    func status() async -> HealthStatus {
        guard let statusResult else {
            fatalError("statusResult not set")
        }

        statusWasCalled = true

        return statusResult
    }

}
