//
//  IdentityMigrations.swift
//  SparkedAPI
//
//  Created by Adam Young on 23/01/2025.
//

import Fluent
import Foundation

struct IdentityMigrations {

    private init() {}

    static func all() -> [any Migration] {
        var migrations: [any Migration] = []
        migrations.append(contentsOf: user())
        migrations.append(contentsOf: role())
        migrations.append(contentsOf: userRole())
        return migrations
    }

}

extension IdentityMigrations {

    package static func user() -> [any Migration] {
        [
            UserMigrationV1()
        ]
    }

    package static func role() -> [any Migration] {
        [
            RoleMigrationV1(),
            RoleMigrationV2()
        ]
    }

    package static func userRole() -> [any Migration] {
        [
            UserRoleMigrationV1()
        ]
    }

}
