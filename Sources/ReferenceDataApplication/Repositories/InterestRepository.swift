//
//  InterestRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 12/03/2025.
//

import Foundation
import ReferenceDataDomain

package protocol InterestRepository: Sendable {

    func fetchAll(
        forInterestGroupID interestGroupID: InterestGroup.ID
    ) async throws(InterestRepositoryError) -> [Interest]

    func fetch(byID id: Interest.ID) async throws(InterestRepositoryError) -> Interest

}

package enum InterestRepositoryError: Error, Equatable {

    case notFound
    case unknown(Error? = nil)

    package static func == (
        lhs: InterestRepositoryError,
        rhs: InterestRepositoryError
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
