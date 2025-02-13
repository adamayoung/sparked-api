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
        return migrations
    }

}

extension IdentityMigrations {

    package static func user() -> [Migration] {
        [
            UserMigrationV1()
        ]
    }

}
