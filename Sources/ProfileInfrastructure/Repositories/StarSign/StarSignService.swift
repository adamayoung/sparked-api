//
//  StarSignService.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation
import ProfileDomain

package protocol StarSignService {

    func fetch(byID id: StarSign.ID) async throws(StarSignServiceError) -> StarSign

}

package enum StarSignServiceError: LocalizedError, Equatable, Sendable {

    case notFound(id: UUID)
    case unknown(Error? = nil)

    package var errorDescription: String? {
        switch self {
        case .notFound(let starSignID):
            "StarSign \(starSignID) not found"

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (lhs: StarSignServiceError, rhs: StarSignServiceError) -> Bool {
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
