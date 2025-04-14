//
//  CountryService.swift
//  SparkedAPI
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation
import ProfileDomain

package protocol CountryService {

    func fetch(byID id: Country.ID) async throws(CountryServiceError) -> Country

}

package enum CountryServiceError: LocalizedError, Equatable, Sendable {

    case notFound(id: UUID)
    case unknown((any Error)? = nil)

    package var errorDescription: String? {
        switch self {
        case .notFound(let countryID):
            "Country \(countryID) not found"

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (lhs: CountryServiceError, rhs: CountryServiceError) -> Bool {
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
