//
//  CountryRepository.swift
//  SparkedAPI
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation
import ProfileDomain

package protocol CountryRepository {

    func fetch(byID id: Country.ID) async throws(CountryRepositoryError) -> Country

}

package enum CountryRepositoryError: Error, Equatable {

    case notFound
    case unknown((any Error)? = nil)

    package static func == (lhs: CountryRepositoryError, rhs: CountryRepositoryError) -> Bool {
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
