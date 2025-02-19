//
//  configureIdentityDatabase.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Fluent
import FluentPostgresDriver
import IdentityInfrastructure
import Vapor

func configureIdentityDatabase(on app: Application) throws {
    let databaseID: DatabaseID = .identity
    try createDatabaseConfiguration(on: app, databaseID: databaseID)

    let migrations = IdentityInfrastructureFactory.makeMigrations()
    for migration in migrations {
        app.migrations.add(migration, to: databaseID)
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

    static var identity: DatabaseID {
        .init(string: "identity")
    }

}
