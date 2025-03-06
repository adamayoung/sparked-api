//
//  FetchProfilePhotoError.swift
//  AdamDateApp
//
//  Created by Adam Young on 06/03/2025.
//

import Foundation

package enum FetchProfilePhotosError: LocalizedError, Equatable, Sendable {

    case notFoundForProfile(profileID: UUID)
    case unknown(Error? = nil)

    package var errorDescription: String? {
        switch self {
        case .notFoundForProfile(let profileID):
            "Profile \(profileID) not found"

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (lhs: FetchProfilePhotosError, rhs: FetchProfilePhotosError) -> Bool {
        switch (lhs, rhs) {
        case (.notFoundForProfile(let lhsProfileID), .notFoundForProfile(let rhsProfileID)):
            lhsProfileID == rhsProfileID

        case (.unknown(let lhsError), .unknown(let rhsError)):
            lhsError?.localizedDescription == rhsError?.localizedDescription

        default:
            false
        }
    }

}
