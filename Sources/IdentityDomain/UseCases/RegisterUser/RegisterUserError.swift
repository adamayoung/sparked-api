//
//  RegisterUserError.swift
//  AdamDateDomain
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation

package enum RegisterUserError: LocalizedError, Equatable {

    case emailAlreadyExists
    case unknown(Error? = nil)

    package var errorDescription: String? {
        switch self {
        case .emailAlreadyExists:
            "Email already exists"

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (lhs: RegisterUserError, rhs: RegisterUserError) -> Bool {
        switch (lhs, rhs) {
        case (.emailAlreadyExists, .emailAlreadyExists):
            return true

        case (.unknown(let lhsError), .unknown(let rhsError)):
            return lhsError?.localizedDescription == rhsError?.localizedDescription

        default:
            return false
        }
    }

}
