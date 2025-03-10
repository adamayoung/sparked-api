//
//  FetchGendersErrorAbortErrorTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 06/02/2025.
//

import Foundation
import ReferenceDataApplication
import Testing

@testable import ReferenceDataWebAPI

@Suite("FetchGendersError+AbortError")
struct FetchGendersErrorAbortErrorTests {

    struct Status {

        @Test("status unknown returns internal server error")
        func statusUnknownReturnsInternalServerError() {
            let error = FetchGendersError.unknown()

            #expect(error.status == .internalServerError)
        }

    }

    struct Reason {

        @Test("reason returns localized description of error")
        func reasonReturnsLocalizedDescriptionOfError() throws {
            let error = FetchGendersError.unknown()

            #expect(error.localizedDescription == error.reason)
        }

    }

}
