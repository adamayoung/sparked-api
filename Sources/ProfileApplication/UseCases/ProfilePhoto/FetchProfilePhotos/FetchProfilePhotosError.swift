//
//  FetchProfilePhotoError.swift
//  SparkedAPI
//
//  Created by Adam Young on 06/03/2025.
//

import Foundation

package enum FetchProfilePhotosError: LocalizedError, Equatable, Sendable {

    case profileNotFound(profileID: UUID)
    case unauthorized
    case unknown((any Error)? = nil)

    package var errorDescription: String? {
        switch self {
        case .profileNotFound(let profileID):
            "Profile \(profileID) not found"

        case .unauthorized:
            "Unauthorised"

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (lhs: FetchProfilePhotosError, rhs: FetchProfilePhotosError) -> Bool {
        switch (lhs, rhs) {
        case (.profileNotFound(let lhsProfileID), .profileNotFound(let rhsProfileID)):
            lhsProfileID == rhsProfileID

        case (.unauthorized, .unauthorized):
            true

        case (.unknown(let lhsError), .unknown(let rhsError)):
            lhsError?.localizedDescription == rhsError?.localizedDescription

        default:
            false
        }
    }

}
