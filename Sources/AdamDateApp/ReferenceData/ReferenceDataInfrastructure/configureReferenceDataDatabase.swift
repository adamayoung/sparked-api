//
//  configureReferenceDataDatabase.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Fluent
import FluentPostgresDriver
import ReferenceDataInfrastructure
import Vapor

func configureReferenceDataDatabase(
    on app: Application
) throws -> (id: DatabaseID, database: Database) {
    let databaseID: DatabaseID = .referenceData
    try createDatabaseConfiguration(on: app, databaseID: databaseID)

    let migrations = ReferenceDataInfrastructureFactory.makeMigrations()
    for migration in migrations {
        app.migrations.add(migration, to: databaseID)
    }

    return (databaseID, app.db(databaseID))
}

private func createDatabaseConfiguration(
    on app: Application,
    databaseID: DatabaseID
) throws {
    guard
        let hostname = Environment.get("POSTGRES_HOSTNAME"),
        let username = Environment.get("POSTGRES_USER"),
        let password = Environment.get("POSTGRES_PASSWORD"),
        let database = Environment.get("POSTGRES_\(databaseID.string.uppercased())_DATABASE")
    else {
        fatalError("Missing required database environment variables for \(databaseID.string)")
    }

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

extension DatabaseID {

    public static var referenceData: DatabaseID {
        .init(string: "reference_data")
    }

}
