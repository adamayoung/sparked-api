//
//  InterestGroupCacheDefaultDataSource.swift
//  AdamDateApp
//
//  Created by Adam Young on 19/03/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

final class InterestGroupCacheDefaultDataSource: InterestGroupCacheDataSource {

    private enum CacheKey {
        private static let prefix =
            "ReferenceDataInfrastructure.InterestGroupCacheDefaultDataSource"

        static let interestGroups = "\(prefix).interestGroups"
    }

    private let cacheProvider: any CacheProvider

    init(cacheProvider: some CacheProvider) {
        self.cacheProvider = cacheProvider
    }

    func fetchAll() async throws(InterestGroupRepositoryError) -> [InterestGroup]? {
        let dictionary = try await interestGroups()

        return dictionary?.values.map(\.self)
    }

    func setInterestGroups(
        _ interestGroups: [InterestGroup]
    ) async throws(InterestGroupRepositoryError) {
        let dictionary = interestGroups.reduce(into: [:]) { dictionary, country in
            dictionary[country.id] = country
        }

        try await setInterestGroups(dictionary)
    }

    func fetch(
        byID id: InterestGroup.ID
    ) async throws(InterestGroupRepositoryError) -> InterestGroup? {
        let dictionary: [InterestGroup.ID: InterestGroup]?
        do {
            dictionary = try await self.interestGroups()
        } catch let error {
            throw .unknown(error)
        }

        return dictionary?[id]
    }

    func setInterestGroup(
        _ interestGroup: InterestGroup
    ) async throws(InterestGroupRepositoryError) {
        let dictionary: [InterestGroup.ID: InterestGroup]?
        do {
            dictionary = try await self.interestGroups()
        } catch let error {
            throw .unknown(error)
        }

        var newDictionary = dictionary ?? [:]
        newDictionary[interestGroup.id] = interestGroup

        do {
            try await setInterestGroups(newDictionary)
        } catch let error {
            throw .unknown(error)
        }
    }

}

extension InterestGroupCacheDefaultDataSource {

    private func interestGroups() async throws(InterestGroupRepositoryError) -> [InterestGroup.ID:
        InterestGroup]?
    {
        do {
            return try await cacheProvider.get(forKey: CacheKey.interestGroups)
        } catch let error {
            throw .unknown(error)
        }
    }

    private func setInterestGroups(
        _ interestGroups: [InterestGroup.ID: InterestGroup]
    ) async throws(InterestGroupRepositoryError) {
        do {
            try await cacheProvider.set(interestGroups, forKey: CacheKey.interestGroups)
        } catch let error {
            throw .unknown(error)
        }
    }

}
