//
//  FetchBasicInfoError.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation

package enum FetchBasicInfoError: LocalizedError, Equatable, Sendable {

    case notFound(profileID: UUID)
    case unknown(Error? = nil)

    package var errorDescription: String? {
        switch self {
        case .notFound(let profileID):
            "Profile \(profileID) not found"

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (lhs: FetchBasicInfoError, rhs: FetchBasicInfoError) -> Bool {
        switch (lhs, rhs) {
        case (.notFound(let lhsProfileID), .notFound(let rhsProfileID)):
            lhsProfileID == rhsProfileID

        case (.unknown(let lhsError), .unknown(let rhsError)):
            lhsError?.localizedDescription == rhsError?.localizedDescription

        default:
            false
        }
    }

}
