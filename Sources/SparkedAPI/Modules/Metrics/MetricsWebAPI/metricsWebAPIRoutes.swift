//
//  metricsWebAPIRoutes.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import MetricsWebAPI
import Vapor

func metricsWebAPIRoutes(_ routes: some RoutesBuilder) throws {
    try routes.register(
        collection: MetricsWebAPIFactory.makeMetricsController()
    )
}
