//
//  healthWebAPIRoutes.swift
//  SparkedAPI
//
//  Created by Adam Young on 14/03/2025.
//

import HealthWebAPI
import Vapor

func healthWebAPIRoutes(_ routes: RoutesBuilder) throws {
    let authRouter = routes.grouped("health")

    try authRouter.register(
        collection: HealthWebAPIFactory.makeHealthController()
    )
}
