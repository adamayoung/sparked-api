//
//  FetchInterestGroupError.swift
//  SparkedAPI
//
//  Created by Adam Young on 12/03/2025.
//

import Foundation

package enum FetchInterestGroupError: LocalizedError, Equatable, Sendable {

    case notFound(interestGroupID: UUID)
    case unknown((any Error)? = nil)

    package var errorDescription: String? {
        switch self {
        case .notFound(let interestGroupID):
            "Interest Group with ID \(interestGroupID) not found"

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (lhs: FetchInterestGroupError, rhs: FetchInterestGroupError) -> Bool {
        switch (lhs, rhs) {
        case (.notFound(let lhsInterestGroupID), .notFound(let rhsInterestGroupID)):
            lhsInterestGroupID == rhsInterestGroupID

        case (.unknown(let lhsError), .unknown(let rhsError)):
            lhsError?.localizedDescription == rhsError?.localizedDescription

        default:
            false
        }
    }

}
