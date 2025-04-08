//
//  profileRoutes.swift
//  SparkedAPI
//
//  Created by Adam Young on 05/02/2025.
//

import ProfileWebAPI
import Vapor

func profileWebAPIRoutes(_ routes: some RoutesBuilder) throws {
    let profilesRouter = routes.grouped("profiles")

    try profilesRouter.register(collection: ProfileWebAPIFactory.makeProfileController())

    try profilesRouter.register(collection: ProfileWebAPIFactory.makeBasicProfileController())

    try profilesRouter.register(collection: ProfileWebAPIFactory.makeBasicInfoController())
    try profilesRouter.register(collection: ProfileWebAPIFactory.makeExtendedInfoController())

    try profilesRouter.register(collection: ProfileWebAPIFactory.makePhotoController())

    try profilesRouter.register(collection: ProfileWebAPIFactory.makeInterestController())
}
