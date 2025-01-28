//
//  routes.swift
//  AdamDateAPI
//
//  Created by Adam Young on 09/01/2025.
//

import IdentityAPI
import ProfileAPI
import Vapor

func routes(_ routes: RoutesBuilder, container: Container) throws {
    let apiRouter = routes.grouped("api")

    try apiRouter.register(collection: container.resolve(ProfileController.self))
    try apiRouter.register(collection: container.resolve(AuthController.self))
}
