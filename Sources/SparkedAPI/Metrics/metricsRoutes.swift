//
//  metricsRoutes.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import MetricsWebAPI
import Vapor

func metricsRoutes(_ routes: RoutesBuilder) throws {
    try routes.register(
        collection: MetricsWebAPIFactory.makeMetricsController()
    )
}
