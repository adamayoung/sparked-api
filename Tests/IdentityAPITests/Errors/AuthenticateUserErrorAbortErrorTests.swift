//
//  AuthenticateUserErrorAbortErrorTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 30/01/2025.
//

import Foundation
import IdentityDomain
import Testing

@testable import IdentityAPI

@Suite("AuthenticateUserError+AbortError")
struct AuthenticateUserErrorAbortErrorTests {

    struct Status {

        @Test("status invalidEmailOrPassword returns unauthorized")
        func statusInvalidEmailOrPasswordStatusReturnsUnauthorized() {
            #expect(AuthenticateUserError.invalidEmailOrPassword.status == .unauthorized)
        }

        @Test("status notVerified status returns forbidden")
        func statusNotVerifiedStatusReturnsForbidden() {
            #expect(AuthenticateUserError.notVerified.status == .forbidden)
        }

        @Test("status userDisabled returns not found")
        func statusUserDisabledReturnsNotFound() {
            #expect(AuthenticateUserError.userDisabled.status == .notFound)
        }

        @Test("status unknown returns internal server error")
        func statusUnknownReturnsInternalServerError() {
            #expect(AuthenticateUserError.unknown().status == .internalServerError)
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
