//
//  identityRoutes.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import IdentityPresentation
import Vapor

func identityRoutes(_ routes: RoutesBuilder, container: Container) throws {
    let authRouter = routes.grouped("auth")
    try authRouter.register(collection: container.resolve(AuthController.self))
}
