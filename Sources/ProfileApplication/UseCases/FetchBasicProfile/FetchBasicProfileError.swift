//
//  FetchBasicProfileError.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation

package enum FetchBasicProfileError: LocalizedError, Equatable, Sendable {

    case notFound(profileID: UUID)
    case notFoundForUser(userID: UUID)
    case userNotFound(userID: UUID)
    case unauthorized
    case unknown(Error? = nil)

    package var errorDescription: String? {
        switch self {
        case .notFound(let profileID):
            "Basic profile \(profileID) not found"

        case .notFoundForUser(let userID):
            "Basic profile for user \(userID) not found"

        case .userNotFound(let userID):
            "User \(userID) not found"

        case .unauthorized:
            "Unauthorized"

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (lhs: FetchBasicProfileError, rhs: FetchBasicProfileError) -> Bool {
        switch (lhs, rhs) {
        case (.notFound(let lhsProfileID), .notFound(let rhsProfileID)):
            lhsProfileID == rhsProfileID

        case (.notFoundForUser(let lhsUserID), .notFoundForUser(let rhsUserID)):
            lhsUserID == rhsUserID

        case (.userNotFound(let lhsUserID), .userNotFound(let rhsUserID)):
            lhsUserID == rhsUserID

        case (.unauthorized, .unauthorized):
            true

        case (.unknown(let lhsError), .unknown(let rhsError)):
            lhsError?.localizedDescription == rhsError?.localizedDescription

        default:
            false
        }
    }

}
