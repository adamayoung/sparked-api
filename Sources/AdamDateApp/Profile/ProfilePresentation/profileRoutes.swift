//
//  profileRoutes.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import ProfilePresentation
import Vapor

func profileRoutes(_ routes: RoutesBuilder, container: Container) throws {
    let profilesRouter = routes.grouped("profiles")

    try profilesRouter.register(
        collection: container.resolve(RouteCollection.self, name: "ProfileController")
    )
    try profilesRouter.register(
        collection: container.resolve(RouteCollection.self, name: "BasicProfileController")
    )
    try profilesRouter.register(
        collection: container.resolve(RouteCollection.self, name: "BasicInfoController")
    )
}
