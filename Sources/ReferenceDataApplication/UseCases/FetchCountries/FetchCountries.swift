//
//  FetchCountries.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation

package final class FetchCountries: FetchCountriesUseCase {

    private let repository: any FetchCountriesRepository

    package init(repository: some FetchCountriesRepository) {
        self.repository = repository
    }

    package func execute() async throws(FetchCountriesError) -> [CountryDTO] {
        let countries = try await repository.countries()
        let countryDTOs = countries.map(CountryDTOMapper.map)
            .sorted { $0.name.localizedCompare($1.name) == .orderedAscending }

        return countryDTOs
    }

}
