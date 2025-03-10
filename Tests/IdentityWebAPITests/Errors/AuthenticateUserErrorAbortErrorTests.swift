//
//  AuthenticateUserErrorAbortErrorTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 30/01/2025.
//

import Foundation
import IdentityApplication
import Testing

@testable import IdentityWebAPI

@Suite("AuthenticateUserError+AbortError")
struct AuthenticateUserErrorAbortErrorTests {

    struct Status {

        @Test("status invalidEmailOrPassword returns unauthorized")
        func statusInvalidEmailOrPasswordReturnsUnauthorized() {
            let status = AuthenticateUserError.invalidEmailOrPassword.status

            #expect(status == .unauthorized)
        }

        @Test("status notVerified returns forbidden")
        func statusNotVerifiedReturnsForbidden() {
            let status = AuthenticateUserError.notVerified.status

            #expect(status == .forbidden)
        }

        @Test("status userDisabled returns not found")
        func statusUserDisabledReturnsNotFound() {
            let status = AuthenticateUserError.userDisabled.status

            #expect(status == .notFound)
        }

        @Test("status unknown returns internal server error")
        func statusUnknownReturnsInternalServerError() {
            let status = AuthenticateUserError.unknown().status

            #expect(status == .internalServerError)
        }

    }

    struct Reason {

        @Test("reason returns localized description of error")
        func reasonReturnsLocalizedDescriptionOfError() {
            let error = AuthenticateUserError.invalidEmailOrPassword

            #expect(error.localizedDescription == error.reason)
        }

    }

}
