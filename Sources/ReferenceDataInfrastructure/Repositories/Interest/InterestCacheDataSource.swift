//
//  InterestCacheDataSource.swift
//  SparkedAPI
//
//  Created by Adam Young on 19/03/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

protocol InterestCacheDataSource: Sendable {

    func fetchAll(
        forInterestGroupID interestGroupID: InterestGroup.ID
    ) async throws(InterestRepositoryError) -> [Interest]?

    func setInterests(
        _ interests: [Interest],
        forInterestGroupID interestGroupID: InterestGroup.ID
    ) async throws(InterestRepositoryError)

    func fetch(byID id: Interest.ID) async throws(InterestRepositoryError) -> Interest?

    func setInterest(_ interest: Interest) async throws(InterestRepositoryError)

}
