//
//  ReferenceDataMigrations.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Fluent
import Foundation

struct ReferenceDataMigrations {

    private init() {}

    package static func all() -> [Migration] {
        var migrations: [Migration] = []
        migrations.append(contentsOf: gender())
        migrations.append(contentsOf: country())
        return migrations
    }

}

extension ReferenceDataMigrations {

    package static func gender() -> [Migration] {
        [
            GenderMigrationV1()
        ]
    }

    package static func country() -> [Migration] {
        [
            CountryMigrationV1()
        ]
    }

}
