//
//  FetchGenderError.swift
//  AdamDateApp
//
//  Created by Adam Young on 13/02/2025.
//

import Foundation

package enum FetchGenderError: LocalizedError, Equatable, Sendable {

    case notFound(genderID: UUID)
    case unknown(Error? = nil)

    package var errorDescription: String? {
        switch self {
        case .notFound(let genderID):
            "Gender with ID \(genderID) not found"

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (lhs: FetchGenderError, rhs: FetchGenderError) -> Bool {
        switch (lhs, rhs) {
        case (.notFound(let lhsGenderID), .notFound(let rhsGenderID)):
            lhsGenderID == rhsGenderID

        case (.unknown(let lhsError), .unknown(let rhsError)):
            lhsError?.localizedDescription == rhsError?.localizedDescription

        default:
            false
        }
    }

}
