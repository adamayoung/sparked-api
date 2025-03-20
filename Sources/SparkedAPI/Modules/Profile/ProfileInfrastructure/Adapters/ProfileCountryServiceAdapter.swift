//
//  ProfileCountryServiceAdapter.swift
//  SparkedAPI
//
//  Created by Adam Young on 13/02/2025.
//

import Foundation
import ProfileDomain
import ProfileInfrastructure
import ReferenceDataApplication

final class ProfileCountryServiceAdapter: CountryService {

    private let fetchCountryUseCase: any FetchCountryUseCase

    init(fetchCountryUseCase: some FetchCountryUseCase) {
        self.fetchCountryUseCase = fetchCountryUseCase
    }

    func fetch(
        byID id: ProfileDomain.Country.ID
    ) async throws(CountryServiceError) -> ProfileDomain.Country {
        let referenceDataCountryDTO: CountryDTO
        do {
            referenceDataCountryDTO = try await fetchCountryUseCase.execute(id: id)
        } catch FetchCountryError.notFound {
            throw .notFound(id: id)
        } catch let error {
            throw .unknown(error)
        }

        let country = ProfileCountryMapper.map(from: referenceDataCountryDTO)

        return country
    }

}
