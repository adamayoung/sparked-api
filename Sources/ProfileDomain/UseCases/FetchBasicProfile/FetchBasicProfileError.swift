//
//  FetchBasicProfileError.swift
//  AdamDateAPI
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation

package enum FetchBasicProfileError: LocalizedError, Equatable, Sendable {

    case notFound(profileID: UUID)
    case userNotFound(userID: UUID)
    case unknown(Error? = nil)

    package var errorDescription: String? {
        switch self {
        case .notFound(let profileID):
            "Basic profile \(profileID) not found"

        case .userNotFound(let userID):
            "Basic profile for user \(userID) not found"

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (lhs: FetchBasicProfileError, rhs: FetchBasicProfileError) -> Bool {
        switch (lhs, rhs) {
        case (.notFound(let lhsProfileID), .notFound(let rhsProfileID)):
            lhsProfileID == rhsProfileID

        case (.userNotFound(let lhsUserID), .userNotFound(let rhsUserID)):
            lhsUserID == rhsUserID

        case (.unknown(let lhsError), .unknown(let rhsError)):
            lhsError?.localizedDescription == rhsError?.localizedDescription

        default:
            false
        }
    }

}
