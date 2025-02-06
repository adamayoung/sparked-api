//
//  FetchCountriesErrorAbortErrorTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 06/02/2025.
//

import Foundation
import ReferenceDataApplication
import Testing

@testable import ReferenceDataPresentation

@Suite("FetchCountriesError+AbortError")
struct FetchCountriesErrorAbortErrorTests {

    struct Status {

        @Test("status unknown returns internal server error")
        func statusUnknownReturnsInternalServerError() {
            let error = FetchCountriesError.unknown()

            #expect(error.status == .internalServerError)
        }

    }

    struct Reason {

        @Test("reason returns localized description of error")
        func reasonReturnsLocalizedDescriptionOfError() throws {
            let error = FetchCountriesError.unknown()

            #expect(error.localizedDescription == error.reason)
        }

    }

}
