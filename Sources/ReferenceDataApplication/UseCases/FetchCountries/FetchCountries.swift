//
//  FetchCountries.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation
import ReferenceDataDomain

final class FetchCountries: FetchCountriesUseCase {

    private let repository: any CountryRepository

    init(repository: some CountryRepository) {
        self.repository = repository
    }

    func execute() async throws(FetchCountriesError) -> [CountryDTO] {
        let countries: [Country]
        do {
            countries = try await repository.fetchAll()
        } catch let error {
            throw .unknown(error)
        }

        let countryDTOs = countries.map(CountryDTOMapper.map)
            .sorted { $0.name.localizedStandardCompare($1.name) == .orderedAscending }

        return countryDTOs
    }

}
