//
//  configure.swift
//  SparkedAPI
//
//  Created by Adam Young on 09/01/2025.
//

import Vapor

func configure(_ app: Application) async throws {
    app.logger.info("Environment: \(app.environment.name.uppercased())")

    try await configureCoreInfrastructure(on: app)
    await configureAuth(on: app)

    configureModules(on: app)
    configureCommands(on: app)

    app.routes.defaultMaxBodySize = "10mb"
    try routes(app, environment: app.environment)
}
