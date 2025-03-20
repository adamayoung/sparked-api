//
//  InterestGroupRemoteDataSource.swift
//  SparkedAPI
//
//  Created by Adam Young on 12/03/2025.
//

import Foundation
import ReferenceDataApplication
import ReferenceDataDomain

protocol InterestGroupRemoteDataSource: Sendable {

    func fetchAll() async throws(InterestGroupRepositoryError) -> [InterestGroup]

    func fetch(
        byID id: InterestGroup.ID
    ) async throws(InterestGroupRepositoryError) -> InterestGroup

}
