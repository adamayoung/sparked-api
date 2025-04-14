//
//  NameValidatorTests.swift
//  SparkedAPI
//
//  Created by Adam Young on 06/02/2025.
//

import Foundation
import Testing

@testable import IdentityDomain

@Suite("NameValidator")
struct NameValidatorTests {

    let validator: NameValidator

    init() {
        self.validator = NameValidator()
    }

    @Test("validate when valid name does not throw error")
    func validateWhenNameIsValidDoesNotThrowError() {
        #expect(throws: Never.self) {
            try validator.validate("Dave")
        }
    }

    @Test("validate when name is empty throws empty error")
    func validateWhenNameIsEmptyThrowsEmptyError() {
        #expect(throws: NameValidationError.empty) {
            try validator.validate("")
        }
    }

}
