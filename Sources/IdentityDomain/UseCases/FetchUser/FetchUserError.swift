//
//  FetchUserError.swift
//  AdamDateAPI
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation

package enum FetchUserError: LocalizedError, Equatable {

    case notFound
    case unknown(Error? = nil)

    package var errorDescription: String? {
        switch self {
        case .notFound:
            "User not found"

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (lhs: FetchUserError, rhs: FetchUserError) -> Bool {
        switch (lhs, rhs) {
        case (.notFound, .notFound):
            return true

        case (.unknown(let lhsError), .unknown(let rhsError)):
            return lhsError?.localizedDescription == rhsError?.localizedDescription

        default:
            return false
        }
    }

}
