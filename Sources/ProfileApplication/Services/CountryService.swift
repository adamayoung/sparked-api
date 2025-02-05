//
//  CountryService.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation

package protocol CountryService {

    func countries() async throws(CountryServiceError) -> [CountryDTO]

}

package enum CountryServiceError: LocalizedError, Equatable {

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
            return lhsError?.localizedDescription == rhsError?.localizedDescription
        }
    }

}
