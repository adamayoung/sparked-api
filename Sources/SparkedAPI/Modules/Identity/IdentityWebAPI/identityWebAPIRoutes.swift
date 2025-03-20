//
//  identityRoutes.swift
//  SparkedAPI
//
//  Created by Adam Young on 05/02/2025.
//

import IdentityWebAPI
import Vapor

func identityWebAPIRoutes(_ routes: RoutesBuilder) throws {
    let authRouter = routes.grouped("auth")

    try authRouter.register(
        collection: IdentityWebAPIFactory.makeMeController()
    )

    try authRouter.register(
        collection: IdentityWebAPIFactory.makeRegisterController()
    )

    try authRouter.register(
        collection: IdentityWebAPIFactory.makeTokenController()
    )
}
