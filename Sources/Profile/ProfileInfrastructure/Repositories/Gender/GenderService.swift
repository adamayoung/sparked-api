//
//  GenderService.swift
//  SparkedAPI
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation
import ProfileDomain

package protocol GenderService {

    func fetch(byID id: Gender.ID) async throws(GenderServiceError) -> Gender

}

package enum GenderServiceError: LocalizedError, Equatable, Sendable {

    case notFound(id: UUID)
    case unknown((any Error)? = nil)

    package var errorDescription: String? {
        switch self {
        case .notFound(let genderID):
            "Gender \(genderID) not found"

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (lhs: GenderServiceError, rhs: GenderServiceError) -> Bool {
        switch (lhs, rhs) {
        case (.notFound(let lhsID), .notFound(let rhsID)):
            lhsID == rhsID

        case (.unknown(let lhsError), .unknown(let rhsError)):
            lhsError?.localizedDescription == rhsError?.localizedDescription

        default:
            false
        }
    }

}
