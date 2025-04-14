//
//  ReferenceDataMigrations.swift
//  SparkedAPI
//
//  Created by Adam Young on 05/02/2025.
//

import Fluent
import Foundation

struct ReferenceDataMigrations {

    private init() {}

    package static func all() -> [any Migration] {
        var migrations: [any Migration] = []
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

    package static func gender() -> [any Migration] {
        [
            GenderMigrationV1(),
            GenderMigrationV2()
        ]
    }

    package static func country() -> [any Migration] {
        [
            CountryMigrationV1(),
            CountryMigrationV2()
        ]
    }

    package static func interestGroup() -> [any Migration] {
        [
            InterestGroupMigrationV1(),
            InterestGroupMigrationV2()
        ]
    }

    package static func interest() -> [any Migration] {
        [
            InterestMigrationV1(),
            InterestMigrationV2()
        ]
    }

    package static func starSign() -> [any Migration] {
        [
            StarSignMigrationV1(),
            StarSignMigrationV2()
        ]
    }

    package static func educationLevel() -> [any Migration] {
        [
            EducationLevelMigrationV1(),
            EducationLevelMigrationV2()
        ]
    }

}
