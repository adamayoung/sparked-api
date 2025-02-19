//
//  FetchCountry.swift
//  AdamDateApp
//
//  Created by Adam Young on 13/02/2025.
//

import Foundation
import ReferenceDataDomain

final class FetchCountry: FetchCountryUseCase {

    private let repository: any CountryRepository

    init(repository: some CountryRepository) {
        self.repository = repository
    }

    func execute(id: CountryDTO.ID) async throws(FetchCountryError) -> CountryDTO {
        let country: Country
        do {
            country = try await repository.fetch(byID: id)
        } catch CountryRepositoryError.notFound {
            throw .notFound(countryID: id)
        } catch let error {
            throw .unknown(error)
        }

        let countryDTO = CountryDTOMapper.map(from: country)

        return countryDTO
    }

}
