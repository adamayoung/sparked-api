//
//  RegisterUserErrorAbortErrorTests.swift
//  SparkedAPI
//
//  Created by Adam Young on 30/01/2025.
//

import Foundation
import IdentityApplication
import Testing

@testable import IdentityWebAPI

@Suite("RegisterUserError+AbortError")
struct RegisterUserErrorAbortErrorTests {

    struct Status {

        @Test("status emailAlreadyExists returns not badRequest")
        func statusEmailAlreadyExistsReturnsBadRequest() {
            let status = RegisterUserError.emailAlreadyExists(email: "email@example.com").status

            #expect(status == .badRequest)
        }

        @Test("status unknown returns internal server error")
        func statusUnknownReturnsInternalServerError() {
            let status = RegisterUserError.unknown().status

            #expect(status == .internalServerError)
        }

    }

    struct Reason {

        @Test("reason returns localized description of error")
        func reasonReturnsLocalizedDescriptionOfError() {
            let error = RegisterUserError.emailAlreadyExists(email: "email@example.com")

            #expect(error.localizedDescription == error.reason)
        }

    }

}
