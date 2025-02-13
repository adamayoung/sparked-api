//
//  FetchCountries.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation

final class FetchCountries: FetchCountriesUseCase {

    private let repository: any CountryRepository

    init(repository: some CountryRepository) {
        self.repository = repository
    }

    func execute() async throws(FetchCountriesError) -> [CountryDTO] {
        let countries = try await repository.fetchAll()
        let countryDTOs = countries.map(CountryDTOMapper.map)
            .sorted { $0.name.localizedCompare($1.name) == .orderedAscending }

        return countryDTOs
    }

}
