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

    package func execute() async throws(FetchCountriesError) -> [Country.ID: Country] {
        let genders = try await repository.countries()
        return genders
    }

}
