//
//  NameValidator.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation

struct NameValidator: Validator {

    func validate(_ value: String) throws(NameValidationError) {
        guard !value.isEmpty else {
            throw .empty
        }
    }

}

package enum NameValidationError: LocalizedError, Sendable {

    case empty

    package var errorDescription: String? {
        switch self {
        case .empty:
            "cannot be empty"
        }
    }

}
