//
//  EducationLevelRepository.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation
import ProfileDomain

package protocol EducationLevelRepository {

    func fetch(
        byID id: EducationLevel.ID
    ) async throws(EducationLevelRepositoryError) -> EducationLevel

}

package enum EducationLevelRepositoryError: Error, Equatable {

    case notFound
    case unknown(Error? = nil)

    package static func == (
        lhs: EducationLevelRepositoryError,
        rhs: EducationLevelRepositoryError
    ) -> Bool {
        switch (lhs, rhs) {
        case (.notFound, .notFound):
            true

        case (.unknown(let lhsError), .unknown(let rhsError)):
            lhsError?.localizedDescription == rhsError?.localizedDescription

        default:
            false
        }
    }

}
