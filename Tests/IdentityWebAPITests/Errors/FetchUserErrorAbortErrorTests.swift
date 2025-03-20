//
//  FetchUserErrorAbortErrorTests.swift
//  SparkedAPI
//
//  Created by Adam Young on 30/01/2025.
//

import Foundation
import IdentityApplication
import Testing

@testable import IdentityWebAPI

@Suite("FetchUserError+AbortError")
struct FetchUserErrorAbortErrorTests {

    struct Status {

        @Test("status notFound by ID returns not found")
        func statusNotFoundByIDReturnsNotFound() throws {
            let id = try #require(UUID(uuidString: "7EEF0B02-16CB-47E7-9705-BC4C9C8E9693"))

            let status = FetchUserError.notFoundByID(userID: id).status

            #expect(status == .notFound)
        }

        @Test("status notFound by email returns not found")
        func statusNotFoundByEmailReturnsNotFound() throws {
            let email = "email@example.com"

            let status = FetchUserError.notFoundByEmail(email: email).status

            #expect(status == .notFound)
        }

        @Test("status unknown returns internal server error")
        func statusUnknownReturnsInternalServerError() {
            let status = FetchUserError.unknown().status

            #expect(status == .internalServerError)
        }

    }

    struct Reason {

        @Test("reason returns localized description of error")
        func reasonReturnsLocalizedDescriptionOfError() {
            let email = "email@example.com"

            let error = FetchUserError.notFoundByEmail(email: email)

            #expect(error.localizedDescription == error.reason)
        }

    }

}
