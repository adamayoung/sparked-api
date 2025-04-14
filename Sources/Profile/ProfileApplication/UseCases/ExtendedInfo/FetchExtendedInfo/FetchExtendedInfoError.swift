//
//  FetchExtendedInfoError.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation

package enum FetchExtendedInfoError: LocalizedError, Equatable, Sendable {

    case notFound(id: UUID)
    case notFoundForUser(userID: UUID)
    case profileNotFound(profileID: UUID)
    case unauthorized
    case unknown((any Error)? = nil)

    package var errorDescription: String? {
        switch self {
        case .notFound(let id):
            "Extended Profile Info \(id) not found"

        case .notFoundForUser(let userID):
            "Extended Profile Info for user \(userID) not found"

        case .profileNotFound(let profileID):
            "Extended Profile Info for profile \(profileID) not found"

        case .unauthorized:
            "Unauthorised"

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (lhs: FetchExtendedInfoError, rhs: FetchExtendedInfoError) -> Bool {
        switch (lhs, rhs) {
        case (.notFound(let lhsID), .notFound(let rhsID)):
            lhsID == rhsID

        case (.notFoundForUser(let lhsUserID), .notFoundForUser(let rhsUserID)):
            lhsUserID == rhsUserID

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
