//
//  PasswordValidator.swift
//  AdamDateApp
//
//  Created by Adam Young on 06/02/2025.
//

import Foundation
import Testing

@testable import IdentityDomain

@Suite("PasswordValidator")
struct PasswordValidatorTests {

    let validator: PasswordValidator

    init() {
        self.validator = PasswordValidator()
    }

    @Test("validate when password is valid does not throw error")
    func validateWhenPasswordIsValidDoesNotThrowError() {
        #expect(throws: Never.self) {
            try validator.validate("Aa123456")
        }
    }

    @Test("validate when password has fewer than 8 characters throws length error")
    func validateWhenPasswordHasFewerThan8CharactersThrowsLengthError() {
        #expect(throws: PasswordValidationError.length(8)) {
            try validator.validate("Aa12345")
        }
    }

    @Test("validate when password has no lowercase characters throws lowercase character error")
    func validateWhenPasswordHasNoLowercaseCharactersThrowsLowercaseCharacterError() {
        #expect(throws: PasswordValidationError.lowercaseCharacter) {
            try validator.validate("AA123456")
        }
    }

    @Test("validate when password has no uppercase characters throws lowercase character error")
    func validateWhenPasswordHasNoLowercaseCharactersThrowsUppercaseCharacterError() {
        #expect(throws: PasswordValidationError.uppercaseCharacter) {
            try validator.validate("aa123456")
        }
    }

    @Test("validate when password has no uppercase characters throws lowercase character error")
    func validateWhenPasswordHasNoDigitsThrowsDigitError() {
        #expect(throws: PasswordValidationError.digit) {
            try validator.validate("Aaaaaaaa")
        }
    }

}
