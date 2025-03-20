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

    static func all() -> [Migration] {
        var migrations: [Migration] = []
        migrations.append(contentsOf: basicProfile())
        migrations.append(contentsOf: basicInfo())
        migrations.append(contentsOf: profilePhoto())
        migrations.append(contentsOf: profileInterest())
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

    package static func profilePhoto() -> [Migration] {
        [
            ProfilePhotoMigrationV1()
        ]
    }

    package static func profileInterest() -> [Migration] {
        [
            ProfileInterestMigrationV1()
        ]
    }

}
