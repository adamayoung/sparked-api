//
//  IdentityMigrations.swift
//  AdamDateApp
//
//  Created by Adam Young on 23/01/2025.
//

import Fluent
import Foundation

struct IdentityMigrations {

    private init() {}

    static func all() -> [Migration] {
        var migrations: [Migration] = []
        migrations.append(contentsOf: user())
        migrations.append(contentsOf: role())
        migrations.append(contentsOf: userRole())
        return migrations
    }

}

extension IdentityMigrations {

    package static func user() -> [Migration] {
        [
            UserMigrationV1()
        ]
    }

    package static func role() -> [Migration] {
        [
            RoleMigrationV1(),
            RoleMigrationV2()
        ]
    }

    package static func userRole() -> [Migration] {
        [
            UserRoleMigrationV1()
        ]
    }

}
