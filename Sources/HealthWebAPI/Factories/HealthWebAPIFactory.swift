//
//  HealthWebAPIFactory.swift
//  SparkedAPI
//
//  Created by Adam Young on 14/03/2025.
//

import Vapor

package final class HealthWebAPIFactory: Sendable {

    private init() {}

    package static func makeHealthController() -> some RouteCollection {
        HealthController()
    }

}
