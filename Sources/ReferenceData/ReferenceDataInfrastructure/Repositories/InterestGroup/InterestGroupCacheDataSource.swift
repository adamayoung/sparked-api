//
//  InterestGroupCacheDataSource.swift
//  SparkedAPI
//
//  Created by Adam Young on 19/03/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

protocol InterestGroupCacheDataSource: Sendable {

    func fetchAll() async throws(InterestGroupRepositoryError) -> [InterestGroup]?

    func setInterestGroups(
        _ interestGroups: [InterestGroup]
    ) async throws(InterestGroupRepositoryError)

    func fetch(
        byID id: InterestGroup.ID
    ) async throws(InterestGroupRepositoryError) -> InterestGroup?

    func setInterestGroup(_ interestGroup: InterestGroup) async throws(InterestGroupRepositoryError)

}
