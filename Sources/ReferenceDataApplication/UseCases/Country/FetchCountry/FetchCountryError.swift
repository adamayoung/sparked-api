//
//  FetchCountryError.swift
//  SparkedAPI
//
//  Created by Adam Young on 13/02/2025.
//

import Foundation

package enum FetchCountryError: LocalizedError, Equatable, Sendable {

    case notFound(countryID: UUID)
    case unknown(Error? = nil)

    package var errorDescription: String? {
        switch self {
        case .notFound(let countryID):
            "Country with ID \(countryID) not found"

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (lhs: FetchCountryError, rhs: FetchCountryError) -> Bool {
        switch (lhs, rhs) {
        case (.notFound(let lhsCountryID), .notFound(let rhsCountryID)):
            lhsCountryID == rhsCountryID

        case (.unknown(let lhsError), .unknown(let rhsError)):
            lhsError?.localizedDescription == rhsError?.localizedDescription

        default:
            false
        }
    }

}
