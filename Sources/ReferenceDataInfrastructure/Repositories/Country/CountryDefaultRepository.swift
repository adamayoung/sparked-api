//
//  CountryDefaultRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

final class CountryDefaultRepository: CountryRepository {

    private let remoteDataSource: any CountryRemoteDataSource
    private let cacheDataSource: any CountryCacheDataSource

    init(
        remoteDataSource: some CountryRemoteDataSource,
        cacheDataSource: some CountryCacheDataSource
    ) {
        self.remoteDataSource = remoteDataSource
        self.cacheDataSource = cacheDataSource
    }

    func fetchAll() async throws(CountryRepositoryError) -> [Country] {
        if let cachedCountries = try? await cacheDataSource.fetchAll() {
            return cachedCountries
        }

        let countries = try await remoteDataSource.fetchAll()
        try? await cacheDataSource.setCountries(countries)

        return countries
    }

    func fetch(byID id: Country.ID) async throws(CountryRepositoryError) -> Country {
        if let cachedCountry = try? await cacheDataSource.fetch(byID: id) {
            return cachedCountry
        }

        let country = try await remoteDataSource.fetch(byID: id)
        try? await cacheDataSource.setCountry(country)

        return country
    }

}
