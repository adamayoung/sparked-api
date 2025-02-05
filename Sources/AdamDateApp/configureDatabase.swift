//
//  configureDatabase.swift
//  AdamDateApp
//
//  Created by Adam Young on 23/01/2025.
//

import Fluent
import Vapor

func configureDatabase(on app: Application) throws -> [DatabaseID: Database] {
    var databases: [DatabaseID: Database] = [:]

    let identityConfig = try configureIdentityDatabase(on: app)
    databases[identityConfig.id] = identityConfig.database

    let profileConfig = try configureProfileDatabase(on: app)
    databases[profileConfig.id] = profileConfig.database

    let referenceDataConfig = try configureReferenceDataDatabase(on: app)
    databases[referenceDataConfig.id] = referenceDataConfig.database

    return databases
}
