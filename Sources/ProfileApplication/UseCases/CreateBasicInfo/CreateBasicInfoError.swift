//
//  CreateBasicInfoError.swift
//  AdamDateApp
//
//  Created by Adam Young on 11/02/2025.
//

import Foundation

package enum CreateBasicInfoError: LocalizedError, Equatable, Sendable {

    case userNotFound(userID: UUID)
    case countryNotFound(countryID: UUID)
    case genderNotFound(genderID: UUID)
    case basicInfoAlreadyExistsForProfile(profileID: UUID)
    case unknown(Error? = nil)

    package var errorDescription: String? {
        switch self {
        case .userNotFound(let userID):
            "User \(userID) not found"

        case .countryNotFound(let countryID):
            "Country \(countryID) not found"

        case .genderNotFound(let genderID):
            "Gender \(genderID) not found"

        case .basicInfoAlreadyExistsForProfile(let profileID):
            "Basic info already exists for profile \(profileID)"

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (lhs: CreateBasicInfoError, rhs: CreateBasicInfoError) -> Bool {
        switch (lhs, rhs) {
        case (.userNotFound(let lhsUserID), .userNotFound(let rhsUserID)):
            lhsUserID == rhsUserID

        case (.countryNotFound(let lhsCountryID), .userNotFound(let rhsCountryID)):
            lhsCountryID == rhsCountryID

        case (.genderNotFound(let lhsGenderID), .genderNotFound(let rhsGenderID)):
            lhsGenderID == rhsGenderID

        case (
            .basicInfoAlreadyExistsForProfile(let lhsProfileID),
            .basicInfoAlreadyExistsForProfile(let rhsProfileID)
        ):
            lhsProfileID == rhsProfileID

        case (.unknown(let lhsError), .unknown(let rhsError)):
            lhsError?.localizedDescription == rhsError?.localizedDescription

        default:
            false
        }
    }

}
