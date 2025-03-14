//
//  InterestDefaultRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 12/03/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

final class InterestDefaultRepository: InterestRepository {

    private let remoteDataSource: any InterestRemoteDataSource

    init(remoteDataSource: some InterestRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func fetchAll(
        forInterestGroupID interestGroupID: InterestGroup.ID
    ) async throws(InterestRepositoryError) -> [Interest] {
        let interests = try await remoteDataSource.fetchAll(forInterestGroupID: interestGroupID)

        return interests
    }

    func fetch(byID id: Interest.ID) async throws(InterestRepositoryError) -> Interest {
        let interest = try await remoteDataSource.fetch(byID: id)

        return interest
    }

}
