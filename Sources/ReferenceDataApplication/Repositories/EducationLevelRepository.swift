//
//  EducationLevelRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 18/03/2025.
//

import Foundation
import ReferenceDataDomain

package protocol EducationLevelRepository: Sendable {

    func fetchAll() async throws(EducationLevelRepositoryError) -> [EducationLevel]

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
            return true
        case (.unknown(let lhsError), .unknown(let rhsError)):
            return lhsError?.localizedDescription == rhsError?.localizedDescription
        default:
            return false
        }
    }

}
