//
//  CreateBasicProfileError.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation

package enum CreateBasicProfileError: LocalizedError, Equatable, Sendable {

    case userNotFound(userID: UUID)
    case profileAlreadyExistsForUser(userID: UUID)
    case unknown(Error? = nil)

    package var errorDescription: String? {
        switch self {
        case .userNotFound(let userID):
            "User \(userID) not found"

        case .profileAlreadyExistsForUser(let userID):
            "Profile already exists for user \(userID)"

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (lhs: CreateBasicProfileError, rhs: CreateBasicProfileError) -> Bool {
        switch (lhs, rhs) {
        case (.userNotFound(let lhsUserID), .userNotFound(let rhsUserID)):
            lhsUserID == rhsUserID

        case (
            .profileAlreadyExistsForUser(let lhsUserID), .profileAlreadyExistsForUser(let rhsUserID)
        ):
            lhsUserID == rhsUserID

        case (.unknown(let lhsError), .unknown(let rhsError)):
            lhsError?.localizedDescription == rhsError?.localizedDescription

        default:
            false
        }
    }

}
