//
//  RoleMigrationV2.swift
//  SparkedAPI
//
//  Created by Adam Young on 19/03/2025.
//

import Fluent
import Foundation

struct RoleMigrationV2: AsyncMigration {

    func prepare(on database: Database) async throws {
        try await database.transaction { database in
            for role in Self.defaultRoles {
                try await role.save(on: database)
            }
        }
    }

    func revert(on database: Database) async throws {
        try await database.transaction { database in
            for role in Self.defaultRoles {
                try await RoleModel
                    .find(role.requireID(), on: database)?
                    .delete(force: true, on: database)
            }
        }
    }

}

extension RoleMigrationV2 {

    static let defaultRoles = [
        RoleModel(
            id: UUID(uuidString: "282D045D-F76A-4B73-A743-F14C5BF8AF97"),
            name: "Administrator",
            code: "ADMIN",
            description: "Administrator role"
        ),
        RoleModel(
            id: UUID(uuidString: "2A9D4B47-52CB-4CD1-9EB4-216BBCDF05B3"),
            name: "User",
            code: "USER",
            description: "User role"
        ),
        RoleModel(
            id: UUID(uuidString: "8082C0AB-66BF-479B-8195-BCB1D0AA24A5"),
            name: "System",
            code: "SYSTEM",
            description: "System role"
        )
    ]

}
