//
//  ProfileCountryAdapter.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation
import ProfileDomain
import ReferenceDataDomain

final class ProfileCountryAdapter: CountryProvider {

    private let fetchCountriesUseCase: any FetchCountriesUseCase

    init(fetchCountriesUseCase: some FetchCountriesUseCase) {
        self.fetchCountriesUseCase = fetchCountriesUseCase
    }

    func countries() async throws(CountryProviderError) -> [ProfileDomain.Country] {
        let countryReferences: [ReferenceDataDomain.Country.ID: ReferenceDataDomain.Country]
        do {
            countryReferences = try await fetchCountriesUseCase.execute()
        } catch let error {
            throw .unknown(error)
        }

        let countries = countryReferences.values
            .map(CountryMapper.map)
            .sorted { $0.name.localizedCompare($1.name) == .orderedAscending }

        return countries
    }

}

private struct CountryMapper {

    private init() {}

    static func map(from country: ReferenceDataDomain.Country) -> ProfileDomain.Country {
        Country(
            id: country.id,
            name: country.name
        )
    }

}
