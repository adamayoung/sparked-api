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
        migrations.append(contentsOf: interestGroup())
        migrations.append(contentsOf: interest())
        migrations.append(contentsOf: starSign())
        migrations.append(contentsOf: educationLevel())
        return migrations
    }

}

extension ReferenceDataMigrations {

    package static func gender() -> [Migration] {
        [
            GenderMigrationV1(),
            GenderMigrationV2()
        ]
    }

    package static func country() -> [Migration] {
        [
            CountryMigrationV1(),
            CountryMigrationV2()
        ]
    }

    package static func interestGroup() -> [Migration] {
        [
            InterestGroupMigrationV1(),
            InterestGroupMigrationV2()
        ]
    }

    package static func interest() -> [Migration] {
        [
            InterestMigrationV1(),
            InterestMigrationV2()
        ]
    }

    package static func starSign() -> [Migration] {
        [
            StarSignMigrationV1(),
            StarSignMigrationV2()
        ]
    }

    package static func educationLevel() -> [Migration] {
        [
            EducationLevelMigrationV1(),
            EducationLevelMigrationV2()
        ]
    }

}
