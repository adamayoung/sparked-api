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

    init(remoteDataSource: some InterestGroupRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func fetchAll() async throws(InterestGroupRepositoryError) -> [InterestGroup] {
        let interestGroups = try await remoteDataSource.fetchAll()

        return interestGroups
    }

    func fetch(
        byID id: InterestGroup.ID
    ) async throws(InterestGroupRepositoryError) -> InterestGroup {
        let interestGroup = try await remoteDataSource.fetch(byID: id)

        return interestGroup
    }

}
