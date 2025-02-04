//
//  configure.swift
//  AdamDateAPI
//
//  Created by Adam Young on 09/01/2025.
//

import Vapor

func configure(_ app: Application) async throws {
    let databases = try configureDatabase(on: app)
    let jwtConfiguration = await configureAuth(app)

    let container = Container()

    let containerConfigurator = DefaultContainerConfigurator(
        container: container,
        databases: databases,
        jwtConfiguration: jwtConfiguration,
        passwordHasher: app.password
    )
    containerConfigurator.configure()

    configureCommands(app, container: container)

    try routes(app, container: container)
}
