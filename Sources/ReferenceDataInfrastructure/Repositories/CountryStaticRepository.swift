//
//  CountryStaticRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation
import ReferenceDataDomain

package final class CountryStaticRepository: CountryRepository {

    package init() {}

    package func countries() async throws(FetchCountriesError) -> [Country.ID: Country] {
        Self.countries
    }

}

extension CountryStaticRepository {

    private static let countries = NSLocale.isoCountryCodes
        .reduce(into: [Country.ID: Country]()) { partialResult, code in
            let id = NSLocale.localeIdentifier(
                fromComponents: [NSLocale.Key.countryCode.rawValue: code]
            )

            guard
                let name = NSLocale(localeIdentifier: "en_GB")
                    .displayName(forKey: NSLocale.Key.identifier, value: id)
            else {
                return
            }

            let country = Country(id: code, name: name)
            partialResult[code] = country
        }

}
