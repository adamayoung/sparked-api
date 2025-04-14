//
//  ProfileMigrations.swift
//  SparkedAPI
//
//  Created by Adam Young on 23/01/2025.
//

import Fluent
import Foundation

struct ProfileMigrations {

    private init() {}

    static func all() -> [any Migration] {
        var migrations: [any Migration] = []
        migrations.append(contentsOf: basicProfile())
        migrations.append(contentsOf: basicInfo())
        migrations.append(contentsOf: profilePhoto())
        migrations.append(contentsOf: profileInterest())
        migrations.append(contentsOf: extendedInfo())
        return migrations
    }

}

extension ProfileMigrations {

    package static func basicProfile() -> [any Migration] {
        [
            BasicProfileMigrationV1()
        ]
    }

    package static func basicInfo() -> [any Migration] {
        [
            BasicInfoMigrationV1()
        ]
    }

    package static func extendedInfo() -> [any Migration] {
        [
            ExtendedInfoMigrationV1()
        ]
    }

    package static func profilePhoto() -> [any Migration] {
        [
            ProfilePhotoMigrationV1()
        ]
    }

    package static func profileInterest() -> [any Migration] {
        [
            ProfileInterestMigrationV1()
        ]
    }

}
