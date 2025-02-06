//
//  EmailValidator.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation

struct EmailValidator: Validator {

    func validate(_ value: String) throws(EmailValidationError) {
        guard !value.isEmpty else {
            throw .empty
        }

        guard value.contains("@") else {
            throw .invalid
        }
    }

}

package enum EmailValidationError: LocalizedError, Sendable {

    case empty
    case invalid

    package var errorDescription: String? {
        switch self {
        case .empty:
            "cannot be empty"

        case .invalid:
            "is invalid"
        }
    }

}
