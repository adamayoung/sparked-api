//
//  AuthenticateUserError.swift
//  SparkedAPI
//
//  Created by Adam Young on 24/01/2025.
//

import Foundation

package enum AuthenticateUserError: LocalizedError, Equatable, Sendable {

    case invalidEmailOrPassword
    case notVerified
    case userDisabled
    case unknown((any Error)? = nil)

    package var errorDescription: String? {
        switch self {
        case .invalidEmailOrPassword:
            "Invalid email or password"

        case .notVerified:
            "Not verified"

        case .userDisabled:
            "User disabled"

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (lhs: AuthenticateUserError, rhs: AuthenticateUserError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidEmailOrPassword, .invalidEmailOrPassword):
            return true
        case (.notVerified, .notVerified):
            return true
        case (.userDisabled, .userDisabled):
            return true
        case (.unknown(let lhsError), .unknown(let rhsError)):
            return lhsError?.localizedDescription == rhsError?.localizedDescription
        default:
            return false
        }
    }

}
