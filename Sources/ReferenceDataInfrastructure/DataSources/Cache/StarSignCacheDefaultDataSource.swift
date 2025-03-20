//
//  StarSignCacheDefaultDataSource.swift
//  SparkedAPI
//
//  Created by Adam Young on 19/03/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

final class StarSignCacheDefaultDataSource: StarSignCacheDataSource {

    private enum CacheKey {
        private static let prefix = "ReferenceDataInfrastructure.StarSignCacheDefaultDataSource"

        static let starSigns = "\(prefix).starSigns"
    }

    private let cacheProvider: any CacheProvider

    init(cacheProvider: some CacheProvider) {
        self.cacheProvider = cacheProvider
    }

    func fetchAll() async throws(StarSignRepositoryError) -> [StarSign]? {
        let dictionary = try await starSigns()

        return dictionary?.values.map(\.self)
    }

    func setStarSigns(_ starSigns: [StarSign]) async throws(StarSignRepositoryError) {
        let dictionary = starSigns.reduce(into: [:]) { dictionary, country in
            dictionary[country.id] = country
        }

        try await setStarSigns(dictionary)
    }

    func fetch(byID id: StarSign.ID) async throws(StarSignRepositoryError) -> StarSign? {
        let dictionary: [StarSign.ID: StarSign]?
        do {
            dictionary = try await self.starSigns()
        } catch let error {
            throw .unknown(error)
        }

        return dictionary?[id]
    }

    func setStarSign(_ starSign: StarSign) async throws(StarSignRepositoryError) {
        let dictionary: [StarSign.ID: StarSign]?
        do {
            dictionary = try await self.starSigns()
        } catch let error {
            throw .unknown(error)
        }

        var newDictionary = dictionary ?? [:]
        newDictionary[starSign.id] = starSign

        do {
            try await setStarSigns(newDictionary)
        } catch let error {
            throw .unknown(error)
        }
    }

}

extension StarSignCacheDefaultDataSource {

    private func starSigns() async throws(StarSignRepositoryError) -> [StarSign.ID: StarSign]? {
        do {
            return try await cacheProvider.get(forKey: CacheKey.starSigns)
        } catch let error {
            throw .unknown(error)
        }
    }

    private func setStarSigns(
        _ starSigns: [StarSign.ID: StarSign]
    ) async throws(StarSignRepositoryError) {
        do {
            try await cacheProvider.set(starSigns, forKey: CacheKey.starSigns)
        } catch let error {
            throw .unknown(error)
        }
    }

}
