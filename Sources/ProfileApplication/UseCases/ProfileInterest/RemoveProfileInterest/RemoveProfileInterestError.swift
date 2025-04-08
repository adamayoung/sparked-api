//
//  RemoveProfileInterestError.swift
//  SparkedAPI
//
//  Created by Adam Young on 18/03/2025.
//

import Foundation

package enum RemoveProfileInterestError: LocalizedError, Equatable, Sendable {

    case profileNotFound(profileID: UUID)
    case interestNotFound(interestID: UUID)
    case unauthorized
    case unknown((any Error)? = nil)

    package var errorDescription: String? {
        switch self {
        case .profileNotFound(let profileID):
            "Profile \(profileID) not found"

        case .interestNotFound(let interestID):
            "Interest \(interestID) not found"

        case .unauthorized:
            "Unauthorised"

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (
        lhs: RemoveProfileInterestError,
        rhs: RemoveProfileInterestError
    ) -> Bool {
        switch (lhs, rhs) {
        case (.profileNotFound(let lhsProfileID), .profileNotFound(let rhsProfileID)):
            lhsProfileID == rhsProfileID

        case (.interestNotFound(let lhsInterestID), .interestNotFound(let rhsInterestID)):
            lhsInterestID == rhsInterestID

        case (.unauthorized, .unauthorized):
            true

        case (.unknown(let lhsError), .unknown(let rhsError)):
            lhsError?.localizedDescription == rhsError?.localizedDescription

        default:
            false
        }
    }

}
