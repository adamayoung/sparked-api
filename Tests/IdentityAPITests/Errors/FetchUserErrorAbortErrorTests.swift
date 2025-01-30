//
//  FetchUserErrorAbortErrorTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 30/01/2025.
//

import Foundation
import IdentityDomain
import Testing

@testable import IdentityAPI

@Suite("FetchUserError+AbortError")
struct FetchUserErrorAbortErrorTests {

    struct Status {

        @Test("status notFound returns not found")
        func statusNotFoundReturnsNotFound() {
            #expect(FetchUserError.notFound.status == .notFound)
        }

        @Test("status unknown returns internal server error")
        func statusUnknownReturnsInternalServerError() {
            #expect(FetchUserError.unknown().status == .internalServerError)
        }

    }

    struct Reason {

        @Test("reason returns localized description of error")
        func reasonReturnsLocalizedDescriptionOfError() {
            let error = FetchUserError.notFound
            #expect(error.localizedDescription == error.reason)
        }

    }

}
