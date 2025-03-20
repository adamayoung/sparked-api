//
//  AddProfileInterestError.swift
//  SparkedAPI
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation

package enum AddProfileInterestError: LocalizedError, Equatable, Sendable {

    case profileNotFound(profileID: UUID)
    case interestNotFound(interestID: UUID)
    case tooManyInterests(maxCount: Int)
    case duplicateInterest(interestID: UUID)
    case unauthorized
    case unknown(Error? = nil)

    package var errorDescription: String? {
        switch self {
        case .profileNotFound(let profileID):
            "Profile \(profileID) not found"

        case .interestNotFound(let interestID):
            "Interest \(interestID) not found"

        case .tooManyInterests(let maxCount):
            "Too many interests (maximum: \(maxCount))"

        case .duplicateInterest(let interestID):
            "Interest \(interestID) already added"

        case .unauthorized:
            "Unauthorized"

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (lhs: AddProfileInterestError, rhs: AddProfileInterestError) -> Bool {
        switch (lhs, rhs) {
        case (.profileNotFound(let lhsProfileID), .profileNotFound(let rhsProfileID)):
            lhsProfileID == rhsProfileID

        case (.tooManyInterests(let lhsMaxCount), .tooManyInterests(let rhsMaxCount)):
            lhsMaxCount == rhsMaxCount

        case (.duplicateInterest(let lhsInterestID), .duplicateInterest(let rhsInterestID)):
            lhsInterestID == rhsInterestID

        case (.unauthorized, .unauthorized):
            true

        case (.unknown(let lhsError), .unknown(let rhsError)):
            lhsError?.localizedDescription == rhsError?.localizedDescription

        default:
            false
        }
    }

}
