//
//  CountryCacheDefaultDataSource.swift
//  SparkedAPI
//
//  Created by Adam Young on 13/02/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

final class CountryCacheDefaultDataSource: CountryCacheDataSource {

    private enum CacheKey {
        private static let prefix = "ReferenceDataInfrastructure.CountryCacheDefaultDataSource"

        static let countries = "\(prefix).countries"
    }

    private let cacheProvider: any CacheProvider

    init(cacheProvider: some CacheProvider) {
        self.cacheProvider = cacheProvider
    }

    func fetchAll() async throws(CountryRepositoryError) -> [Country]? {
        let dictionary = try await countries()

        return dictionary?.values.map(\.self)
    }

    func setCountries(_ countries: [Country]) async throws(CountryRepositoryError) {
        let dictionary = countries.reduce(into: [:]) { dictionary, country in
            dictionary[country.id] = country
        }

        try await setCountries(dictionary)
    }

    func fetch(byID id: Country.ID) async throws(CountryRepositoryError) -> Country? {
        let dictionary: [Country.ID: Country]?
        do {
            dictionary = try await self.countries()
        } catch let error {
            throw .unknown(error)
        }

        return dictionary?[id]
    }

    func setCountry(_ country: Country) async throws(CountryRepositoryError) {
        let dictionary: [Country.ID: Country]?
        do {
            dictionary = try await self.countries()
        } catch let error {
            throw .unknown(error)
        }

        var newDictionary = dictionary ?? [:]
        newDictionary[country.id] = country

        do {
            try await setCountries(newDictionary)
        } catch let error {
            throw .unknown(error)
        }
    }

}

extension CountryCacheDefaultDataSource {

    private func countries() async throws(CountryRepositoryError) -> [Country.ID: Country]? {
        do {
            return try await cacheProvider.get(forKey: CacheKey.countries)
        } catch let error {
            throw .unknown(error)
        }
    }

    private func setCountries(
        _ countries: [Country.ID: Country]
    ) async throws(CountryRepositoryError) {
        do {
            try await cacheProvider.set(countries, forKey: CacheKey.countries)
        } catch let error {
            throw .unknown(error)
        }
    }

}
