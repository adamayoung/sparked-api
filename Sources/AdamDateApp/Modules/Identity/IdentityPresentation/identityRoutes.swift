//
//  identityRoutes.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import IdentityPresentation
import Vapor

func identityRoutes(_ routes: RoutesBuilder) throws {
    let authRouter = routes.grouped("auth")

    try authRouter.register(
        collection: IdentityPresentationFactory.makeMeController()
    )

    try authRouter.register(
        collection: IdentityPresentationFactory.makeRegisterController()
    )

    try authRouter.register(
        collection: IdentityPresentationFactory.makeTokenController()
    )
}
