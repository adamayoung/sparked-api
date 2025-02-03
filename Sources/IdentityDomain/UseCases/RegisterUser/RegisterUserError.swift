//
//  RegisterUserError.swift
//  AdamDateDomain
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation

package enum RegisterUserError: LocalizedError, Equatable, Sendable {

    case emailAlreadyExists(email: String)
    case unknown(Error? = nil)

    package var errorDescription: String? {
        switch self {
        case .emailAlreadyExists(let email):
            "Email \(email) already exists"

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (lhs: RegisterUserError, rhs: RegisterUserError) -> Bool {
        switch (lhs, rhs) {
        case (.emailAlreadyExists(let lhsEmail), .emailAlreadyExists(let rhsEmail)):
            lhsEmail == rhsEmail

        case (.unknown(let lhsError), .unknown(let rhsError)):
            lhsError?.localizedDescription == rhsError?.localizedDescription

        default:
            false
        }
    }

}
