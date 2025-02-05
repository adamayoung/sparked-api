//
//  configure.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import Vapor

func configure(_ app: Application) async throws {
    let databases = try configureDatabase(on: app)
    let jwtConfiguration = await configureAuth(app)

    let container = Container()

    let containerConfigurator = AdamDateContainerConfigurator(
        databases: databases,
        jwtConfiguration: jwtConfiguration,
        passwordHasher: app.password
    )
    container.configure(with: containerConfigurator)

    configureCommands(app, container: container)

    try routes(app, container: container)
}
