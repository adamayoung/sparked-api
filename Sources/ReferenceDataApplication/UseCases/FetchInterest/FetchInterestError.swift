//
//  FetchInterestError.swift
//  SparkedAPI
//
//  Created by Adam Young on 12/03/2025.
//

import Foundation

package enum FetchInterestError: LocalizedError, Equatable, Sendable {

    case notFound(interestID: UUID)
    case unknown(Error? = nil)

    package var errorDescription: String? {
        switch self {
        case .notFound(let interestID):
            "Interest with ID \(interestID) not found"

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (lhs: FetchInterestError, rhs: FetchInterestError) -> Bool {
        switch (lhs, rhs) {
        case (.notFound(let lhsInterestID), .notFound(let rhsInterestID)):
            lhsInterestID == rhsInterestID

        case (.unknown(let lhsError), .unknown(let rhsError)):
            lhsError?.localizedDescription == rhsError?.localizedDescription

        default:
            false
        }
    }

}
