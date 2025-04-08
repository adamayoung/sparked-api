//
//  FetchStarSignsError.swift
//  SparkedAPI
//
//  Created by Adam Young on 18/03/2025.
//

import Foundation

package enum FetchStarSignsError: LocalizedError, Equatable, Sendable {

    case unknown((any Error)? = nil)

    package var errorDescription: String? {
        switch self {

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (lhs: FetchStarSignsError, rhs: FetchStarSignsError) -> Bool {
        switch (lhs, rhs) {
        case (.unknown(let lhsError), .unknown(let rhsError)):
            lhsError?.localizedDescription == rhsError?.localizedDescription
        }
    }

}
