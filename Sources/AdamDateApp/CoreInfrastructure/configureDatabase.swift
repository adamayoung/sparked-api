//
//  configureDatabase.swift
//  AdamDateApp
//
//  Created by Adam Young on 23/01/2025.
//

import Fluent
import FluentPostgresDriver
import FluentSQLiteDriver
import IdentityInfrastructure
import ProfileInfrastructure
import ReferenceDataInfrastructure
import Vapor

func configureDatabase(on app: Application) async throws {
    let databaseID: DatabaseID = .adamDate

    if app.environment == .testing {
        createTestDatabaseConfiguration(on: app, databaseID: databaseID)
    } else {
        try createDatabaseConfiguration(on: app, databaseID: databaseID)
    }

    addMigrations(on: app, databaseID: databaseID)

    if app.environment == .testing {
        try await app.autoMigrate()
    }
}

private func createDatabaseConfiguration(
    on app: Application,
    databaseID: DatabaseID
) throws {
    guard
        let hostname = Environment.get("POSTGRES_HOSTNAME"),
        let username = Environment.get("POSTGRES_USER"),
        let password = Environment.get("POSTGRES_PASSWORD"),
        let database = Environment.get("POSTGRES_DATABASE")
    else {
        fatalError("Missing required database environment variables for \(databaseID.string)")
    }

    app.logger.info("Using database \(hostname)")

    let configuration = try SQLPostgresConfiguration(
        hostname: hostname,
        username: username,
        password: password,
        database: database,
        tls: .prefer(.init(configuration: .clientDefault))
    )

    let configFactory = DatabaseConfigurationFactory.postgres(configuration: configuration)
    app.databases.use(configFactory, as: databaseID)
}

private func createTestDatabaseConfiguration(on app: Application, databaseID: DatabaseID) {
    app.databases.use(.sqlite(.memory), as: databaseID)
}

private func addMigrations(on app: Application, databaseID: DatabaseID) {
    let migrations =
        IdentityInfrastructureFactory.makeMigrations()
        + ProfileInfrastructureFactory.makeMigrations()
        + ReferenceDataInfrastructureFactory.makeMigrations()

    for migration in migrations {
        app.migrations.add(migration, to: databaseID)
    }
}

extension DatabaseID {

    static var adamDate: DatabaseID {
        .init(string: "adamDate")
    }

}
