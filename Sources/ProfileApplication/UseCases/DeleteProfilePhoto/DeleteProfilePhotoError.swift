//
//  DeleteProfilePhotoError.swift
//  AdamDateApp
//
//  Created by Adam Young on 11/03/2025.
//

import Foundation

package enum DeleteProfilePhotoError: LocalizedError, Equatable, Sendable {

    case profileNotFound(profileID: UUID)
    case profilePhotoNotFound(profilePhotoID: UUID)
    case unknown(Error? = nil)

    package var errorDescription: String? {
        switch self {
        case .profileNotFound(let profileID):
            "Profile \(profileID) not found"

        case .profilePhotoNotFound(let profilePhotoID):
            "Profile photo \(profilePhotoID) not found"

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (
        lhs: DeleteProfilePhotoError,
        rhs: DeleteProfilePhotoError
    ) -> Bool {
        switch (lhs, rhs) {
        case (.profileNotFound(let lhsProfileID), .profileNotFound(let rhsProfileID)):
            lhsProfileID == rhsProfileID

        case (
            .profilePhotoNotFound(let lhsProfilePhotoID),
            .profilePhotoNotFound(let rhsProfilePhotoID)
        ):
            lhsProfilePhotoID == rhsProfilePhotoID

        case (.unknown(let lhsError), .unknown(let rhsError)):
            lhsError?.localizedDescription == rhsError?.localizedDescription

        default:
            false
        }
    }

}
