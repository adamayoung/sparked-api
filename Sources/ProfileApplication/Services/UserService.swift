//
//  UserService.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation

package protocol UserService {

    @discardableResult
    func fetch(byID id: UUID) async throws(UserServiceError) -> UserDTO

}

package enum UserServiceError: LocalizedError, Equatable {

    case notFound
    case unknown(Error? = nil)

    package var errorDescription: String? {
        switch self {
        case .notFound:
            "User not found"

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (lhs: UserServiceError, rhs: UserServiceError) -> Bool {
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
