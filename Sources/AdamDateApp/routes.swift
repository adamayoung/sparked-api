//
//  routes.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import Vapor

func routes(_ routes: RoutesBuilder, container: Container) throws {
    let apiRouter = routes.grouped("api")

    try profileRoutes(apiRouter, container: container)
    try identityRoutes(apiRouter, container: container)
    try referenceDataRoutes(apiRouter, container: container)
}
