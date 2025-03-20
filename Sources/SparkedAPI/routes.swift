//
//  routes.swift
//  SparkedAPI
//
//  Created by Adam Young on 09/01/2025.
//

import Vapor

func routes(_ routes: RoutesBuilder, environment: Environment) throws {
    let apiRouter = routes.grouped("api")
    try webAPIRoutes(apiRouter)
}
