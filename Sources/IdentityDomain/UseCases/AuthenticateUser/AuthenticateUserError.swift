//
//  AuthenticateUserError.swift
//  AdamDateApp
//
//  Created by Adam Young on 24/01/2025.
//

import Foundation

package enum AuthenticateUserError: LocalizedError, Sendable {

    case invalidEmailOrPassword
    case notVerified
    case userDisabled
    case unknown(Error? = nil)

    package var errorDescription: String? {
        switch self {
        case .invalidEmailOrPassword:
            "invalid email or password"

        case .notVerified:
            "not verified"

        case .userDisabled:
            "user disabled"

        case .unknown(let error):
            error?.localizedDescription ?? "Unknown error"
        }
    }

}
