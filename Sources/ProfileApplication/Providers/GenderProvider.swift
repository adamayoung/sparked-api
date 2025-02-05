//
//  GenderProvider.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation
import ProfileDomain

package protocol GenderProvider {

    func genders() async throws(GenderProviderError) -> [Gender]

}

package enum GenderProviderError: LocalizedError, Equatable {

    case unknown(Error? = nil)

    package var errorDescription: String? {
        switch self {
        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (lhs: GenderProviderError, rhs: GenderProviderError) -> Bool {
        switch (lhs, rhs) {
        case (.unknown(let lhsError), .unknown(let rhsError)):
            return lhsError?.localizedDescription == rhsError?.localizedDescription
        }
    }

}
