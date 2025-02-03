//
//  configureDatabase.swift
//  AdamDateApp
//
//  Created by Adam Young on 23/01/2025.
//

import Fluent
import FluentPostgresDriver
import IdentityInfrastructure
import ProfileInfrastructure
import Vapor

func configureDatabase(on app: Application) throws -> [DatabaseID: Database] {
    let databaseIDs: [DatabaseID] = [.profile, .identity]
    for databaseID in databaseIDs {
        try createDatabaseConfiguration(on: app, databaseID: databaseID)
    }

    var migrations: [DatabaseID: [Migration]] = [:]
    migrations[.profile] = ProfileInfrastructure.migrations()
    migrations[.identity] = IdentityInfrastructure.migrations()

    for (databaseID, migrations) in migrations {
        for migration in migrations {
            app.migrations.add(migration, to: databaseID)
        }
    }

    var databases: [DatabaseID: Database] = [:]
    for databaseID in databaseIDs {
        databases[databaseID] = app.db(databaseID)
    }

    return databases
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

    public static var profile: DatabaseID {
        .init(string: "profile")
    }

    public static var identity: DatabaseID {
        .init(string: "identity")
    }

}
