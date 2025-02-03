//
//  CreateBasicProfileErrorAbortErrorTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 30/01/2025.
//

import Foundation
import ProfileDomain
import Testing

@testable import ProfileAPI

@Suite("CreateBasicProfileError+AbortError")
struct CreateBasicProfileErrorAbortErrorTests {

    struct Status {

        @Test("status user not found returns not found")
        func statusUserNotFoundReturnsNotFound() throws {
            let userID = try #require(UUID(uuidString: "E30DE47A-E931-41EA-BD96-AABBBB9FDA54"))

            let status = CreateBasicProfileError.userNotFound(userID: userID).status

            #expect(status == .notFound)
        }

        @Test("status profile already exists for user returns bad request")
        func statusProfileAlreadyExistsForUserReturnsBadRequest() throws {
            let userID = try #require(UUID(uuidString: "E30DE47A-E931-41EA-BD96-AABBBB9FDA54"))

            let status = CreateBasicProfileError.profileAlreadyExistsForUser(userID: userID).status

            #expect(status == .badRequest)
        }

        @Test("status unknown returns internal server error")
        func statusUnknownReturnsInternalServerError() {
            let status = CreateBasicProfileError.unknown().status

            #expect(status == .internalServerError)
        }

    }

    struct Reason {

        @Test("reason returns localized description of error")
        func reasonReturnsLocalizedDescriptionOfError() throws {
            let userID = try #require(UUID(uuidString: "E30DE47A-E931-41EA-BD96-AABBBB9FDA54"))

            let error = CreateBasicProfileError.userNotFound(userID: userID)

            #expect(error.localizedDescription == error.reason)
        }

    }

}
