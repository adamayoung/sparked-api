//
//  FetchProfileInterestsError.swift
//  AdamDateApp
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation

package enum FetchProfileInterestsError: LocalizedError, Equatable, Sendable {

    case profileNotFound(profileID: UUID)
    case unauthorized
    case unknown(Error? = nil)

    package var errorDescription: String? {
        switch self {
        case .profileNotFound(let profileID):
            "Profile \(profileID) not found"

        case .unauthorized:
            "Unauthorised"

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (
        lhs: FetchProfileInterestsError,
        rhs: FetchProfileInterestsError
    ) -> Bool {
        switch (lhs, rhs) {
        case (.profileNotFound(let lhsProfileID), .profileNotFound(let rhsProfileID)):
            lhsProfileID == rhsProfileID

        case (.unauthorized, .unauthorized):
            true

        case (.unknown(let lhsError), .unknown(let rhsError)):
            lhsError?.localizedDescription == rhsError?.localizedDescription

        default:
            false
        }
    }

}
