//
//  ProfileCountryAdapter.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation
import ProfileApplication
import ReferenceDataApplication

final class ProfileCountryAdapter: CountryService {

    private let fetchCountriesUseCase: any FetchCountriesUseCase

    init(fetchCountriesUseCase: some FetchCountriesUseCase) {
        self.fetchCountriesUseCase = fetchCountriesUseCase
    }

    func countries() async throws(CountryServiceError) -> [ProfileApplication.CountryDTO] {
        let countryReferences: [ReferenceDataApplication.CountryDTO]
        do {
            countryReferences = try await fetchCountriesUseCase.execute()
        } catch let error {
            throw .unknown(error)
        }

        let countryDTOs = countryReferences.map(ProfileCountryDTOMapper.map)

        return countryDTOs
    }

}

private struct ProfileCountryDTOMapper {

    private init() {}

    static func map(
        from country: ReferenceDataApplication.CountryDTO
    ) -> ProfileApplication.CountryDTO {
        CountryDTO(
            id: country.id,
            code: country.code,
            name: country.name
        )
    }

}
