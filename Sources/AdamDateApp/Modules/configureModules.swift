//
//  configureModules.swift
//  AdamDateApp
//
//  Created by Adam Young on 19/02/2025.
//

import Vapor

func configureModules(on app: Application) {
    configureProfileModule(on: app)
    configureIdentityModule(on: app)
    configureReferenceDataModule(on: app)
}
