//
//  profileRoutes.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import ProfilePresentation
import Vapor

func profileRoutes(_ routes: RoutesBuilder) throws {
    let profilesRouter = routes.grouped("profiles")

    try profilesRouter.register(
        collection: ProfilePresentationFactory.makeProfileController()
    )
    try profilesRouter.register(
        collection: ProfilePresentationFactory.makeBasicProfileController()
    )
    try profilesRouter.register(
        collection: ProfilePresentationFactory.makeBasicInfoController()
    )
    try profilesRouter.register(
        collection: ProfilePresentationFactory.makePhotoController()
    )
}
