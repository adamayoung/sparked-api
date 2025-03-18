//
//  InterestRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation
import ProfileDomain

package protocol InterestRepository {

    func fetch(byID id: Interest.ID) async throws(InterestRepositoryError) -> Interest

}

package enum InterestRepositoryError: Error, Equatable {

    case notFound
    case unknown(Error? = nil)

    package static func == (lhs: InterestRepositoryError, rhs: InterestRepositoryError) -> Bool {
        switch (lhs, rhs) {
        case (.notFound, .notFound):
            return true
        case (.unknown(let lhsError), .unknown(let rhsError)):
            return lhsError?.localizedDescription == rhsError?.localizedDescription
        default:
            return false
        }
    }

}
