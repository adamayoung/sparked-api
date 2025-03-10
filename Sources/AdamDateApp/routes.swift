//
//  routes.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import Vapor

func routes(_ routes: RoutesBuilder) throws {
    let apiRouter = routes.grouped("api")

    try profileWebAPIRoutes(apiRouter)
    try identityWebAPIRoutes(apiRouter)
    try referenceDataWebAPIRoutes(apiRouter)
}
