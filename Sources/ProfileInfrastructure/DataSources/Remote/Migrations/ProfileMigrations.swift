//
//  ProfileMigrations.swift
//  AdamDateApp
//
//  Created by Adam Young on 23/01/2025.
//

import Fluent
import Foundation

struct ProfileMigrations {

    private init() {}

    static func all() -> [Migration] {
        var migrations: [Migration] = []
        migrations.append(contentsOf: basicProfile())
        migrations.append(contentsOf: basicInfo())
        return migrations
    }

}

extension ProfileMigrations {

    package static func basicProfile() -> [Migration] {
        [
            BasicProfileMigrationV1()
        ]
    }

    package static func basicInfo() -> [Migration] {
        [
            BasicInfoMigrationV1()
        ]
    }

}
