//
//  CountryDefaultRepository.swift
//  SparkedAPI
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation
import ProfileApplication
import ProfileDomain

final class CountryDefaultRepository: CountryRepository {

    private let countryService: any CountryService

    init(countryService: some CountryService) {
        self.countryService = countryService
    }

    func fetch(byID id: Country.ID) async throws(CountryRepositoryError) -> Country {
        let country: Country
        do {
            country = try await countryService.fetch(byID: id)
        } catch CountryServiceError.notFound {
            throw .notFound
        } catch let error {
            throw .unknown(error)
        }

        return country
    }

}
