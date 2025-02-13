//
//  FetchProfileError.swift
//  AdamDateApp
//
//  Created by Adam Young on 12/02/2025.
//

import Foundation

package enum FetchProfileError: LocalizedError, Equatable, Sendable {

    case notFound(profileID: UUID)
    case notFoundForUser(userID: UUID)
    case unknown(Error? = nil)

    package var errorDescription: String? {
        switch self {
        case .notFound(let profileID):
            "Basic profile \(profileID) not found"

        case .notFoundForUser(let userID):
            "Basic profile for user \(userID) not found"

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (lhs: FetchProfileError, rhs: FetchProfileError) -> Bool {
        switch (lhs, rhs) {
        case (.notFound(let lhsProfileID), .notFound(let rhsProfileID)):
            lhsProfileID == rhsProfileID

        case (.notFoundForUser(let lhsUserID), .notFoundForUser(let rhsUserID)):
            lhsUserID == rhsUserID

        case (.unknown(let lhsError), .unknown(let rhsError)):
            lhsError?.localizedDescription == rhsError?.localizedDescription

        default:
            false
        }
    }

}
