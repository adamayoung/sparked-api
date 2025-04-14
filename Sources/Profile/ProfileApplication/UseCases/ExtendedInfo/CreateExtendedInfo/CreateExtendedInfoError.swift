//
//  CreateExtendedInfoError.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation

package enum CreateExtendedInfoError: LocalizedError, Equatable, Sendable {

    case profileNotFound(profileID: UUID)
    case educationLevelNotFound(educationLevelID: UUID)
    case starSignNotFound(starSignID: UUID)
    case extendedInfoAlreadyExistsForProfile(profileID: UUID)
    case unauthorized
    case unknown((any Error)? = nil)

    package var errorDescription: String? {
        switch self {
        case .profileNotFound(let profileID):
            "Profile \(profileID) not found"

        case .educationLevelNotFound(let educationLevelID):
            "Education level \(educationLevelID) not found"

        case .starSignNotFound(let starSignID):
            "Star sign \(starSignID) not found"

        case .extendedInfoAlreadyExistsForProfile(let profileID):
            "Extended info already exists for profile \(profileID)"

        case .unauthorized:
            "Unauthorized"

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (lhs: CreateExtendedInfoError, rhs: CreateExtendedInfoError) -> Bool {
        switch (lhs, rhs) {
        case (.profileNotFound(let lhsProfileID), .profileNotFound(let rhsProfileID)):
            lhsProfileID == rhsProfileID

        case (
            .educationLevelNotFound(let lhsEducationLevelID),
            .educationLevelNotFound(let rhsEducationLevelID)
        ):
            lhsEducationLevelID == rhsEducationLevelID

        case (.starSignNotFound(let lhsStarSignID), .starSignNotFound(let rhsStarSignID)):
            lhsStarSignID == rhsStarSignID

        case (
            .extendedInfoAlreadyExistsForProfile(let lhsProfileID),
            .extendedInfoAlreadyExistsForProfile(let rhsProfileID)
        ):
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
