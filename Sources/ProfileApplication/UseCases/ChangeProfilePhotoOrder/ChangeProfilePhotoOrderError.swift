//
//  ChangeProfilePhotoOrderError.swift
//  AdamDateApp
//
//  Created by Adam Young on 11/03/2025.
//

import Foundation

package enum ChangeProfilePhotoOrderError: LocalizedError, Equatable, Sendable {

    case profileNotFound(profileID: UUID)
    case profilePhotoNotFound(profilePhotoID: UUID)
    case invalidIndex(index: Int, maxIndex: Int)
    case unauthorized
    case unknown(Error? = nil)

    package var errorDescription: String? {
        switch self {
        case .profileNotFound(let profileID):
            "Profile \(profileID) not found"

        case .profilePhotoNotFound(let profilePhotoID):
            "Profile photo \(profilePhotoID) not found"

        case .invalidIndex(let index, let maxIndex):
            "Invalid index \(index) - must be between 0 and \(maxIndex)"

        case .unauthorized:
            "Unauthorized"

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (
        lhs: ChangeProfilePhotoOrderError,
        rhs: ChangeProfilePhotoOrderError
    ) -> Bool {
        switch (lhs, rhs) {
        case (.profileNotFound(let lhsProfileID), .profileNotFound(let rhsProfileID)):
            lhsProfileID == rhsProfileID

        case (
            .profilePhotoNotFound(let lhsProfilePhotoID),
            .profilePhotoNotFound(let rhsProfilePhotoID)
        ):
            lhsProfilePhotoID == rhsProfilePhotoID

        case (
            .invalidIndex(let lhsIndex, let lhsMaxIndex),
            .invalidIndex(let rhsIndex, let rhsMaxIndex)
        ):
            lhsIndex == rhsIndex && lhsMaxIndex == rhsMaxIndex

        case (.unauthorized, .unauthorized):
            true

        case (.unknown(let lhsError), .unknown(let rhsError)):
            lhsError?.localizedDescription == rhsError?.localizedDescription

        default:
            false
        }
    }

}
