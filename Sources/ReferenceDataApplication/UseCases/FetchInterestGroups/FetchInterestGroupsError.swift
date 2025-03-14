//
//  FetchInterestGroupsError.swift
//  AdamDateApp
//
//  Created by Adam Young on 12/03/2025.
//

import Foundation

package enum FetchInterestGroupsError: LocalizedError, Equatable, Sendable {

    case unknown(Error? = nil)

    package var errorDescription: String? {
        switch self {

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (lhs: FetchInterestGroupsError, rhs: FetchInterestGroupsError) -> Bool {
        switch (lhs, rhs) {
        case (.unknown(let lhsError), .unknown(let rhsError)):
            lhsError?.localizedDescription == rhsError?.localizedDescription
        }
    }

}
