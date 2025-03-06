//
//  AddProfilePhotoError.swift
//  AdamDateApp
//
//  Created by Adam Young on 19/02/2025.
//

import Foundation

package enum AddProfilePhotoError: LocalizedError, Equatable, Sendable {

    case profileNotFound(profileID: UUID)
    case unknown(Error? = nil)

    package var errorDescription: String? {
        switch self {
        case .profileNotFound(let profileID):
            "Profile \(profileID) not found"

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (lhs: AddProfilePhotoError, rhs: AddProfilePhotoError) -> Bool {
        switch (lhs, rhs) {
        case (.profileNotFound(let lhsProfileID), .profileNotFound(let rhsProfileID)):
            lhsProfileID == rhsProfileID

        case (.unknown(let lhsError), .unknown(let rhsError)):
            lhsError?.localizedDescription == rhsError?.localizedDescription

        default:
            false
        }
    }

}
