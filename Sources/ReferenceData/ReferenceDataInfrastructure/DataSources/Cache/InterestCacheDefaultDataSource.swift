//
//  InterestCacheDefaultDataSource.swift
//  SparkedAPI
//
//  Created by Adam Young on 19/03/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

final class InterestCacheDefaultDataSource: InterestCacheDataSource {

    private enum CacheKey {
        private static let prefix = "ReferenceDataInfrastructure.InterestCacheDefaultDataSource"

        static let interests = "\(prefix).interests"
        static let interestsInInterestGroup = "\(prefix).interests-in-interest-group"
    }

    private let cacheProvider: any CacheProvider

    init(cacheProvider: some CacheProvider) {
        self.cacheProvider = cacheProvider
    }

    func fetchAll(
        forInterestGroupID interestGroupID: InterestGroup.ID
    ) async throws(InterestRepositoryError) -> [Interest]? {
        let interests = try await interests(forInterestGroupID: interestGroupID)

        return interests
    }

    func setInterests(
        _ interests: [Interest],
        forInterestGroupID interestGroupID: InterestGroup.ID
    ) async throws(InterestRepositoryError) {
        let dictionary = interests.reduce(into: [:]) { dictionary, country in
            dictionary[country.id] = country
        }

        try await setInterests(dictionary, forInterestGroupID: interestGroupID)
    }

    func fetch(
        byID id: Interest.ID
    ) async throws(InterestRepositoryError) -> Interest? {
        let dictionary: [Interest.ID: Interest]?
        do {
            dictionary = try await self.interests()
        } catch let error {
            throw .unknown(error)
        }

        return dictionary?[id]
    }

    func setInterest(
        _ interest: Interest
    ) async throws(InterestRepositoryError) {
        let dictionary: [Interest.ID: Interest]?
        do {
            dictionary = try await self.interests()
        } catch let error {
            throw .unknown(error)
        }

        var newDictionary = dictionary ?? [:]
        newDictionary[interest.id] = interest

        do {
            try await setInterests(newDictionary)
        } catch let error {
            throw .unknown(error)
        }
    }

}

extension InterestCacheDefaultDataSource {

    private func interests(
        forInterestGroupID interestGroupID: InterestGroup.ID
    ) async throws(InterestRepositoryError) -> [Interest]? {
        let interestsInInterestGroup: [InterestGroup.ID: [Interest.ID]]?
        let allInterests: [Interest.ID: Interest]?

        do {
            interestsInInterestGroup = try await cacheProvider.get(
                forKey: CacheKey.interestsInInterestGroup)
            allInterests = try await cacheProvider.get(forKey: CacheKey.interests)
        } catch let error {
            throw .unknown(error)
        }

        guard
            let interestsInInterestGroup,
            let allInterests,
            let interestIDs = interestsInInterestGroup[interestGroupID]
        else {
            return nil
        }

        let interests = interestIDs.compactMap { allInterests[$0] }
        guard interestIDs.count == interests.count else {
            return nil
        }

        return interests
    }

    private func setInterests(
        _ interests: [Interest.ID: Interest],
        forInterestGroupID interestGroupID: InterestGroup.ID
    ) async throws(InterestRepositoryError) {
        try await setInterests(interests)

        var interestsInInterestGroup: [InterestGroup.ID: [Interest.ID]]
        do {
            interestsInInterestGroup =
                try await cacheProvider
                .get(forKey: CacheKey.interestsInInterestGroup) ?? [:]
        } catch let error {
            throw .unknown(error)
        }

        interestsInInterestGroup[interestGroupID] = interests.keys.map { $0 }
        do {
            try await cacheProvider
                .set(interestsInInterestGroup, forKey: CacheKey.interestsInInterestGroup)
        } catch let error {
            throw .unknown(error)
        }
    }

    private func interests() async throws(InterestRepositoryError) -> [Interest.ID: Interest]? {
        do {
            return try await cacheProvider.get(forKey: CacheKey.interests)
        } catch let error {
            throw .unknown(error)
        }
    }

    private func setInterests(
        _ interests: [Interest.ID: Interest]
    ) async throws(InterestRepositoryError) {
        var allInterests: [Interest.ID: Interest]

        do {
            allInterests = (try await cacheProvider.get(forKey: CacheKey.interests)) ?? [:]
        } catch let error {
            throw .unknown(error)
        }

        for (id, interest) in interests {
            allInterests[id] = interest
        }

        do {
            try await cacheProvider.set(allInterests, forKey: CacheKey.interests)
        } catch let error {
            throw .unknown(error)
        }
    }

}
