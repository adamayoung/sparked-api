//
//  FetchUserError.swift
//  SparkedAPI
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation

package enum FetchUserError: LocalizedError, Equatable, Sendable {

    case notFoundByID(userID: UUID)
    case notFoundByEmail(email: String)
    case unknown((any Error)? = nil)

    package var errorDescription: String? {
        switch self {
        case .notFoundByID(let userID):
            "User \(userID) not found"

        case .notFoundByEmail(let email):
            "User \(email) not found"

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (lhs: FetchUserError, rhs: FetchUserError) -> Bool {
        switch (lhs, rhs) {
        case (.notFoundByID(let lhsUserID), .notFoundByID(let rhsUserID)):
            lhsUserID == rhsUserID

        case (.notFoundByEmail(let lhsEmail), .notFoundByEmail(let rhsEmailID)):
            lhsEmail == rhsEmailID

        case (.unknown(let lhsError), .unknown(let rhsError)):
            lhsError?.localizedDescription == rhsError?.localizedDescription

        default:
            false
        }
    }

}
