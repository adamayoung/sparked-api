//
//  PasswordValidator.swift
//  SparkedAPI
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation

package struct PasswordValidator: Validator {

    private static let minPasswordLength = 8

    package init() {}

    package func validate(_ password: String) throws(PasswordValidationError) {
        // Check for minimum length
        guard password.count >= Self.minPasswordLength else {
            throw .length(Self.minPasswordLength)
        }

        // Check for at least one lowercase character
        guard password.contains(/.*[a-z]+.*/) else {
            throw .lowercaseCharacter
        }

        // Check for at least one uppercase character
        guard password.contains(/.*[A-Z]+.*/) else {
            throw .uppercaseCharacter
        }

        // Check for at least one digit
        guard password.contains(/.*[0-9]+.*/) else {
            throw .digit
        }
    }

}

package enum PasswordValidationError: LocalizedError, Equatable, Sendable {

    case lowercaseCharacter
    case uppercaseCharacter
    case digit
    case length(Int)

    package var errorDescription: String? {
        switch self {
        case .lowercaseCharacter:
            "must contain at least one lowercase character"

        case .uppercaseCharacter:
            "must contain at least one uppercase character"

        case .digit:
            "must contain at least one digit"

        case .length(let minLength):
            "must be at least \(minLength) characters long"
        }
    }

}
