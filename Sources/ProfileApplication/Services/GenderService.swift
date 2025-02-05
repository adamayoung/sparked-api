//
//  GenderService.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation

package protocol GenderService {

    func genders() async throws(GenderServiceError) -> [GenderDTO]

}

package enum GenderServiceError: LocalizedError, Equatable {

    case unknown(Error? = nil)

    package var errorDescription: String? {
        switch self {
        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (lhs: GenderServiceError, rhs: GenderServiceError) -> Bool {
        switch (lhs, rhs) {
        case (.unknown(let lhsError), .unknown(let rhsError)):
            return lhsError?.localizedDescription == rhsError?.localizedDescription
        }
    }

}
