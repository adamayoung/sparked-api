//
//  configureCoreInfrastructure.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import Vapor

func configureCoreInfrastructure(on app: Application) async throws {
    try configureDatabase(on: app)
    try configureFileStorage(on: app)
}
