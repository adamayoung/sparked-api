//
//  RegisterUserError.swift
//  SparkedDomain
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation
import IdentityDomain

package enum RegisterUserError: LocalizedError, Equatable, Sendable {

    case validation(ValidationError)
    case emailAlreadyExists(email: String)
    case roleNotFound(roleCode: String)
    case unknown(Error? = nil)

    init(error: UserValidationError) {
        let validationError = RegisterUserError.ValidationError(error: error)
        self = .validation(validationError)
    }

    init(error: PasswordValidationError) {
        let validationError = RegisterUserError.ValidationError(error: error)
        self = .validation(validationError)
    }

    package var errorDescription: String? {
        switch self {
        case .validation(let error):
            "Validation error: \(error.localizedDescription)"

        case .emailAlreadyExists(let email):
            "Email \(email) already exists"

        case .roleNotFound(let roleCode):
            "Role with code \(roleCode) not found"

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (lhs: RegisterUserError, rhs: RegisterUserError) -> Bool {
        switch (lhs, rhs) {
        case (.validation(let lhsError), .validation(let rhsError)):
            lhsError.localizedDescription == rhsError.localizedDescription

        case (.emailAlreadyExists(let lhsEmail), .emailAlreadyExists(let rhsEmail)):
            lhsEmail == rhsEmail

        case (.roleNotFound(let lhsRoleCode), .roleNotFound(let rhsRoleCode)):
            lhsRoleCode == rhsRoleCode

        case (.unknown(let lhsError), .unknown(let rhsError)):
            lhsError?.localizedDescription == rhsError?.localizedDescription

        default:
            false
        }
    }

}

extension RegisterUserError {

    package enum ValidationError: LocalizedError {
        case firstNameEmpty
        case familyNameEmpty
        case emailEmpty
        case emailInvalid
        case passwordOneLowercaseCharacter
        case passwordOneUppercaseCharacter
        case passwordOneDigit
        case passwordLength(Int)

        package var errorDescription: String? {
            switch self {
            case .firstNameEmpty:
                "firstName cannot be empty"
            case .familyNameEmpty:
                "familyName cannot be empty"
            case .emailEmpty:
                "email cannot be empty"
            case .emailInvalid:
                "email is not a valid format"
            case .passwordOneLowercaseCharacter:
                "password must contain at least one lowercase character"
            case .passwordOneUppercaseCharacter:
                "password must contain at least one uppercase character"
            case .passwordOneDigit:
                "password must contain at least one digit"
            case .passwordLength(let minLength):
                "password must have at least \(minLength) characters"
            }
        }
    }

}

extension RegisterUserError.ValidationError {

    init(error: UserValidationError) {
        switch error {
        case .invalidFirstName(let nameValidationError):
            switch nameValidationError {
            case .empty: self = .firstNameEmpty
            }

        case .invalidFamilyName(let nameValidationError):
            switch nameValidationError {
            case .empty: self = .familyNameEmpty
            }

        case .invalidEmail(let emailValidationError):
            switch emailValidationError {
            case .empty: self = .emailEmpty
            case .invalid: self = .emailInvalid
            }
        }
    }

}

extension RegisterUserError.ValidationError {

    init(error: PasswordValidationError) {
        switch error {
        case .lowercaseCharacter: self = .passwordOneLowercaseCharacter
        case .uppercaseCharacter: self = .passwordOneUppercaseCharacter
        case .digit: self = .passwordOneDigit
        case .length(let minLength): self = .passwordLength(minLength)
        }
    }

}
