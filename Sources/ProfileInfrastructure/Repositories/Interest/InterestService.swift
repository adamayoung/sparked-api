//
//  InterestService.swift
//  SparkedAPI
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation
import ProfileDomain

package protocol InterestService {

    func fetch(byID id: Interest.ID) async throws(InterestServiceError) -> Interest

}

package enum InterestServiceError: LocalizedError, Equatable, Sendable {

    case notFound(id: UUID)
    case unknown(Error? = nil)

    package var errorDescription: String? {
        switch self {
        case .notFound(let interestID):
            "Interest \(interestID) not found"

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (lhs: InterestServiceError, rhs: InterestServiceError) -> Bool {
        switch (lhs, rhs) {
        case (.notFound(let lhsID), .notFound(let rhsID)):
            lhsID == rhsID

        case (.unknown(let lhsError), .unknown(let rhsError)):
            lhsError?.localizedDescription == rhsError?.localizedDescription

        default:
            false
        }
    }

}
