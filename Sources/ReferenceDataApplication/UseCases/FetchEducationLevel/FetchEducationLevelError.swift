//
//  FetchEducationLevelError.swift
//  SparkedAPI
//
//  Created by Adam Young on 18/03/2025.
//

import Foundation

package enum FetchEducationLevelError: LocalizedError, Equatable, Sendable {

    case notFound(educationLevelID: UUID)
    case unknown(Error? = nil)

    package var errorDescription: String? {
        switch self {
        case .notFound(let educationLevelID):
            "EducationLevel with ID \(educationLevelID) not found"

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (lhs: FetchEducationLevelError, rhs: FetchEducationLevelError) -> Bool {
        switch (lhs, rhs) {
        case (.notFound(let lhsEducationLevelID), .notFound(let rhsEducationLevelID)):
            lhsEducationLevelID == rhsEducationLevelID

        case (.unknown(let lhsError), .unknown(let rhsError)):
            lhsError?.localizedDescription == rhsError?.localizedDescription

        default:
            false
        }
    }

}
