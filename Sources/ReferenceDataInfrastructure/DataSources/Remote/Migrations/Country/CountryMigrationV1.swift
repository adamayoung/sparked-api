//
//  CountryMigrationV1.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Fluent
import Foundation

struct CountryMigrationV1: AsyncMigration {

    func prepare(on database: Database) async throws {
        try await database.schema("country")
            .id()
            .field("code", .string, .required)
            .field("name", .string, .required)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .field("deleted_at", .datetime)
            .unique(on: "code")
            .unique(on: "name")
            .create()

        for isoCountryCode in NSLocale.isoCountryCodes {
            let countryCode = NSLocale.localeIdentifier(
                fromComponents: [NSLocale.Key.countryCode.rawValue: isoCountryCode]
            )

            guard
                let name = NSLocale(localeIdentifier: "en_GB")
                    .displayName(forKey: NSLocale.Key.identifier, value: countryCode)
            else {
                return
            }

            let country = CountryModel(code: isoCountryCode, name: name)
            try await country.save(on: database)
        }
    }

    func revert(on database: Database) async throws {
        try await database.schema("country").delete()
    }

}
