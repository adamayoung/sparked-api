//
//  UserRegistrationValidator.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation

package struct UserValidator: Validator {

    package init() {}

    package func validate(_ user: User) throws(UserValidationError) {
        try validate(firstName: user.firstName)
        try validate(familyName: user.familyName)
        try validate(email: user.email)
    }

}

extension UserValidator {

    private func validate(firstName: String) throws(UserValidationError) {
        let validator = NameValidator()
        do {
            try validator.validate(firstName)
        } catch let error {
            throw .invalidFirstName(error)
        }
    }

    private func validate(familyName: String) throws(UserValidationError) {
        let validator = NameValidator()
        do {
            try validator.validate(familyName)
        } catch let error {
            throw .invalidFamilyName(error)
        }
    }

    private func validate(email: String) throws(UserValidationError) {
        let validator = EmailValidator()
        do {
            try validator.validate(email)
        } catch let error {
            throw .invalidEmail(error)
        }
    }

}

package enum UserValidationError: LocalizedError {

    case invalidFirstName(NameValidationError)
    case invalidFamilyName(NameValidationError)
    case invalidEmail(EmailValidationError)

    package var errorDescription: String? {
        switch self {
        case .invalidFirstName(let error):
            "firstName \(error.localizedDescription)"

        case .invalidFamilyName(let error):
            "familyName \(error.localizedDescription)"

        case .invalidEmail(let error):
            "email \(error.localizedDescription)"
        }
    }

}
