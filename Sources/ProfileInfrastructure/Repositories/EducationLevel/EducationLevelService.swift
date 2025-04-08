//
//  EducationLevelService.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation
import ProfileDomain

package protocol EducationLevelService {

    func fetch(
        byID id: EducationLevel.ID
    ) async throws(EducationLevelServiceError) -> EducationLevel

}

package enum EducationLevelServiceError: LocalizedError, Equatable, Sendable {

    case notFound(id: UUID)
    case unknown((any Error)? = nil)

    package var errorDescription: String? {
        switch self {
        case .notFound(let genderID):
            "Education level \(genderID) not found"

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (
        lhs: EducationLevelServiceError,
        rhs: EducationLevelServiceError
    ) -> Bool {
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
