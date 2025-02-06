//
//  EmailValidatorTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 06/02/2025.
//

import Foundation
import Testing

@testable import IdentityDomain

@Suite("EmailValidator")
struct EmailValidatorTests {

    let validator: EmailValidator

    init() {
        self.validator = EmailValidator()
    }

    @Test("validate when email is valid does not throw error")
    func validateWhenEmailIsValidDoesNotThrowError() {
        #expect(throws: Never.self) {
            try validator.validate("email@example.com")
        }
    }

    @Test("validate when email is empty throws empty error")
    func validateWhenEmailIsEmptyThrowsEmptyError() {
        #expect(throws: EmailValidationError.empty) {
            try validator.validate("")
        }
    }

    @Test("validate when email does not contain @ character throws invalid error")
    func validateWhenEmailDoesNotContainAtCharacterThrowsInvalidError() {
        #expect(throws: EmailValidationError.invalid) {
            try validator.validate("example.com")
        }
    }

}
