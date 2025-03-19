//
//  InterestGroupDefaultRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 12/03/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

final class InterestGroupDefaultRepository: InterestGroupRepository {

    private let remoteDataSource: any InterestGroupRemoteDataSource
    private let cacheDataSource: any InterestGroupCacheDataSource

    init(
        remoteDataSource: some InterestGroupRemoteDataSource,
        cacheDataSource: some InterestGroupCacheDataSource
    ) {
        self.remoteDataSource = remoteDataSource
        self.cacheDataSource = cacheDataSource
    }

    func fetchAll() async throws(InterestGroupRepositoryError) -> [InterestGroup] {
        if let cachedInterestGroups = try? await cacheDataSource.fetchAll() {
            return cachedInterestGroups
        }

        let interestGroups = try await remoteDataSource.fetchAll()
        try? await cacheDataSource.setInterestGroups(interestGroups)

        return interestGroups
    }

    func fetch(
        byID id: InterestGroup.ID
    ) async throws(InterestGroupRepositoryError) -> InterestGroup {
        if let cachedInterestGroup = try? await cacheDataSource.fetch(byID: id) {
            return cachedInterestGroup
        }

        let interestGroup = try await remoteDataSource.fetch(byID: id)
        try? await cacheDataSource.setInterestGroup(interestGroup)

        return interestGroup
    }

}
