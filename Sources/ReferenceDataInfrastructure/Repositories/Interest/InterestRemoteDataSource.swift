//
//  InterestRemoteDataSource.swift
//  AdamDateApp
//
//  Created by Adam Young on 12/03/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

protocol InterestRemoteDataSource: Sendable {

    func fetchAll(
        forInterestGroupID interestGroupID: InterestGroup.ID
    ) async throws(InterestRepositoryError) -> [Interest]

    func fetch(byID id: Interest.ID) async throws(InterestRepositoryError) -> Interest

}
