//
//  configureIdentityModule.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import IdentityWebAPI
import Vapor

func configureIdentityModule(on app: Application) {
    app.identityUseCases.use(.default)
    app.identityServices.use(.default)
}
