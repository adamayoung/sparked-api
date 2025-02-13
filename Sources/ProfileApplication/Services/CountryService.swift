//
//  CountryService.swift
//  AdamDateApp
//
//  Created by Adam Young on 13/02/2025.
//

import Foundation

package protocol CountryService {

    func doesCountryExist(withID id: UUID) async throws(CountryServiceError) -> Bool

}

package enum CountryServiceError: LocalizedError, Equatable, Sendable {

    case unknown(Error? = nil)

    package var errorDescription: String? {
        switch self {
        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (lhs: CountryServiceError, rhs: CountryServiceError) -> Bool {
        switch (lhs, rhs) {
        case (.unknown(let lhsError), .unknown(let rhsError)):
            lhsError?.localizedDescription == rhsError?.localizedDescription
        }
    }

}
