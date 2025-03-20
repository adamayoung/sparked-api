//
//  FetchStarSignError.swift
//  SparkedAPI
//
//  Created by Adam Young on 18/03/2025.
//

import Foundation

package enum FetchStarSignError: LocalizedError, Equatable, Sendable {

    case notFound(starSignID: UUID)
    case unknown(Error? = nil)

    package var errorDescription: String? {
        switch self {
        case .notFound(let starSignID):
            "StarSign with ID \(starSignID) not found"

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (lhs: FetchStarSignError, rhs: FetchStarSignError) -> Bool {
        switch (lhs, rhs) {
        case (.notFound(let lhsStarSignID), .notFound(let rhsStarSignID)):
            lhsStarSignID == rhsStarSignID

        case (.unknown(let lhsError), .unknown(let rhsError)):
            lhsError?.localizedDescription == rhsError?.localizedDescription

        default:
            false
        }
    }

}
