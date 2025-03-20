//
//  FetchProfilePhotosError.swift
//  AdamDateApp
//
//  Created by Adam Young on 06/03/2025.
//

import Foundation

package enum FetchProfilePhotoError: LocalizedError, Equatable, Sendable {

    case notFound(id: UUID)
    case unauthorized
    case unknown(Error? = nil)

    package var errorDescription: String? {
        switch self {
        case .notFound(let id):
            "Profile photo \(id) not found"

        case .unauthorized:
            "Unauthorised"

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (lhs: FetchProfilePhotoError, rhs: FetchProfilePhotoError) -> Bool {
        switch (lhs, rhs) {
        case (.notFound(let lhsID), .notFound(let rhsID)):
            lhsID == rhsID

        case (.unauthorized, .unauthorized):
            true

        case (.unknown(let lhsError), .unknown(let rhsError)):
            lhsError?.localizedDescription == rhsError?.localizedDescription

        default:
            false
        }
    }

}
