//
//  StarSignRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 18/03/2025.
//

import Foundation
import ReferenceDataDomain

package protocol StarSignRepository: Sendable {

    func fetchAll() async throws(StarSignRepositoryError) -> [StarSign]

    func fetch(byID id: StarSign.ID) async throws(StarSignRepositoryError) -> StarSign

}

package enum StarSignRepositoryError: Error, Equatable {

    case notFound
    case unknown(Error? = nil)

    package static func == (lhs: StarSignRepositoryError, rhs: StarSignRepositoryError) -> Bool {
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
