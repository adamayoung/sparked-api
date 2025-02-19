//
//  GenderCacheDefaultDataSource.swift
//  AdamDateApp
//
//  Created by Adam Young on 13/02/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

final class GenderCacheDefaultDataSource: GenderCacheDataSource {

    private enum CacheKey {
        private static let prefix = "ReferenceDataInfrastructure.GenderCacheDefaultDataSource"

        static let genders = "\(prefix).genders"
    }

    private let cacheProvider: any CacheProvider

    init(cacheProvider: some CacheProvider) {
        self.cacheProvider = cacheProvider
    }

    func fetchAll() async throws(GenderRepositoryError) -> [Gender]? {
        let dictionary = try await genders()

        return dictionary?.values.map(\.self)
    }

    func setGenders(_ genders: [Gender]) async throws(GenderRepositoryError) {
        let dictionary = genders.reduce(into: [:]) { dictionary, country in
            dictionary[country.id] = country
        }

        try await setGenders(dictionary)
    }

    func fetch(byID id: Gender.ID) async throws(GenderRepositoryError) -> Gender? {
        let dictionary: [Gender.ID: Gender]?
        do {
            dictionary = try await self.genders()
        } catch let error {
            throw .unknown(error)
        }

        return dictionary?[id]
    }

    func setGender(_ gender: Gender) async throws(GenderRepositoryError) {
        let dictionary: [Gender.ID: Gender]?
        do {
            dictionary = try await self.genders()
        } catch let error {
            throw .unknown(error)
        }

        var newDictionary = dictionary ?? [:]
        newDictionary[gender.id] = gender

        do {
            try await setGenders(newDictionary)
        } catch let error {
            throw .unknown(error)
        }
    }

}

extension GenderCacheDefaultDataSource {

    private func genders() async throws(GenderRepositoryError) -> [Gender.ID: Gender]? {
        do {
            return try await cacheProvider.get(forKey: CacheKey.genders)
        } catch let error {
            throw .unknown(error)
        }
    }

    private func setGenders(
        _ genders: [Gender.ID: Gender]
    ) async throws(GenderRepositoryError) {
        do {
            try await cacheProvider.set(genders, forKey: CacheKey.genders)
        } catch let error {
            throw .unknown(error)
        }
    }

}
