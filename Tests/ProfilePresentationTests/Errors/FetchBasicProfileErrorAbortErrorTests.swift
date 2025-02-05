//
//  FetchBasicProfileErrorAbortErrorTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 30/01/2025.
//

import Foundation
import ProfileApplication
import Testing

@testable import ProfilePresentation

@Suite("FetchBasicProfileError+AbortError")
struct FetchBasicProfileErrorAbortErrorTests {

    struct Status {

        @Test("status not found returns not found")
        func statusNotFoundReturnsNotFound() throws {
            let profileID = try #require(UUID(uuidString: "E30DE47A-E931-41EA-BD96-AABBBB9FDA54"))

            let status = FetchBasicProfileError.notFound(profileID: profileID).status

            #expect(status == .notFound)
        }

        @Test("status user not found returns not found")
        func statusUserNotFoundReturnsNotFound() throws {
            let userID = try #require(UUID(uuidString: "E30DE47A-E931-41EA-BD96-AABBBB9FDA54"))

            let status = FetchBasicProfileError.userNotFound(userID: userID).status

            #expect(status == .notFound)
        }

        @Test("status unknown returns internal server error")
        func statusUnknownReturnsInternalServerError() {
            let status = FetchBasicProfileError.unknown().status

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
