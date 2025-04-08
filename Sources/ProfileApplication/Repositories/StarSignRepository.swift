//
//  StarSignRepository.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation
import ProfileDomain

package protocol StarSignRepository {

    func fetch(byID id: StarSign.ID) async throws(StarSignRepositoryError) -> StarSign

}

package enum StarSignRepositoryError: Error, Equatable {

    case notFound
    case unknown((any Error)? = nil)

    package static func == (lhs: StarSignRepositoryError, rhs: StarSignRepositoryError) -> Bool {
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
