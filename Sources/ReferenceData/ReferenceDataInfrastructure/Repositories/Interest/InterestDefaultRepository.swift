//
//  InterestDefaultRepository.swift
//  SparkedAPI
//
//  Created by Adam Young on 12/03/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

final class InterestDefaultRepository: InterestRepository {

    private let remoteDataSource: any InterestRemoteDataSource
    private let cacheDataSource: any InterestCacheDataSource

    init(
        remoteDataSource: some InterestRemoteDataSource,
        cacheDataSource: some InterestCacheDataSource
    ) {
        self.remoteDataSource = remoteDataSource
        self.cacheDataSource = cacheDataSource
    }

    func fetchAll(
        forInterestGroupID interestGroupID: InterestGroup.ID
    ) async throws(InterestRepositoryError) -> [Interest] {
        if let cachedInterestGroups =
            try? await cacheDataSource
            .fetchAll(forInterestGroupID: interestGroupID)
        {
            return cachedInterestGroups
        }

        let interests = try await remoteDataSource.fetchAll(forInterestGroupID: interestGroupID)
        try? await cacheDataSource.setInterests(interests, forInterestGroupID: interestGroupID)

        return interests
    }

    func fetch(byID id: Interest.ID) async throws(InterestRepositoryError) -> Interest {
        if let cachedInterestGroup = try? await cacheDataSource.fetch(byID: id) {
            return cachedInterestGroup
        }

        let interest = try await remoteDataSource.fetch(byID: id)
        try? await cacheDataSource.setInterest(interest)

        return interest
    }

}
