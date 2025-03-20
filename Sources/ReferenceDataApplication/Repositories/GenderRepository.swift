//
//  FetchGendersRepository.swift
//  SparkedAPI
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation
import ReferenceDataDomain

package protocol GenderRepository: Sendable {

    func fetchAll() async throws(GenderRepositoryError) -> [Gender]

    func fetch(byID id: Gender.ID) async throws(GenderRepositoryError) -> Gender

}

package enum GenderRepositoryError: Error, Equatable {

    case notFound
    case unknown(Error? = nil)

    package static func == (lhs: GenderRepositoryError, rhs: GenderRepositoryError) -> Bool {
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
