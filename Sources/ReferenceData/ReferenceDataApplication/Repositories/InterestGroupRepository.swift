//
//  InterestGroupRepository.swift
//  SparkedAPI
//
//  Created by Adam Young on 12/03/2025.
//

import Foundation
import ReferenceDataDomain

package protocol InterestGroupRepository: Sendable {

    func fetchAll() async throws(InterestGroupRepositoryError) -> [InterestGroup]

    func fetch(
        byID id: InterestGroup.ID
    ) async throws(InterestGroupRepositoryError) -> InterestGroup

}

package enum InterestGroupRepositoryError: Error, Equatable {

    case notFound
    case unknown((any Error)? = nil)

    package static func == (
        lhs: InterestGroupRepositoryError,
        rhs: InterestGroupRepositoryError
    ) -> Bool {
        switch (lhs, rhs) {
        case (.notFound, .notFound):
            true
        case (.unknown(let lhsError), .unknown(let rhsError)):
            lhsError?.localizedDescription == rhsError?.localizedDescription
        default:
            false
        }
    }

}
