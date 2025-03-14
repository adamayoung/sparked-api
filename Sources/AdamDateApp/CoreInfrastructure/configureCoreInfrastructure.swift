//
//  configureCoreInfrastructure.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import Vapor

func configureCoreInfrastructure(on app: Application) async throws {
    try await configureDatabase(on: app)
    configureFileStorage(on: app)
}
