//
//  HealthService.swift
//  AdamDateApp
//
//  Created by Adam Young on 14/03/2025.
//

import Foundation

package protocol HealthService: Sendable {

    func status() async -> HealthStatus

}
