//
//  MetricsWebAPIFactory.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Vapor

package final class MetricsWebAPIFactory: Sendable {

    private init() {}

    package static func makeMetricsController() -> some RouteCollection {
        MetricsController()
    }

}
