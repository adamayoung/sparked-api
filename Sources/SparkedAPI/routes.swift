//
//  routes.swift
//  SparkedAPI
//
//  Created by Adam Young on 09/01/2025.
//

import Metrics
import Prometheus
import Vapor

func routes(_ routes: RoutesBuilder, environment: Environment) throws {
    let apiRouter = routes.grouped("api")
    try webAPIRoutes(apiRouter)

    let metricsRouter = routes.grouped("metrics")
    try metricsRoutes(metricsRouter)
}
