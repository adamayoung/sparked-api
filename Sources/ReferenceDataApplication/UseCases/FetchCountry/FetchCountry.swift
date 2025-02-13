//
//  FetchCountry.swift
//  AdamDateApp
//
//  Created by Adam Young on 13/02/2025.
//

import Foundation

final class FetchCountry: FetchCountryUseCase {

    private let repository: any CountryRepository

    init(repository: some CountryRepository) {
        self.repository = repository
    }

    func execute(id: CountryDTO.ID) async throws(FetchCountryError) -> CountryDTO {
        let country = try await repository.fetch(byID: id)
        let countryDTO = CountryDTOMapper.map(from: country)

        return countryDTO
    }

}
