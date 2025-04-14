//
//  UserService.swift
//  SparkedAPI
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation
import ProfileDomain

package protocol UserService {

    func fetch(byID id: User.ID) async throws(UserServiceError) -> User

}

package enum UserServiceError: LocalizedError, Equatable, Sendable {

    case notFound(userID: UUID)
    case unknown((any Error)? = nil)

    package var errorDescription: String? {
        switch self {
        case .notFound(let userID):
            "User \(userID) not found"

        case .unknown(let error):
            "Unknown error: \(error?.localizedDescription ?? "No description available")"
        }
    }

    package static func == (lhs: UserServiceError, rhs: UserServiceError) -> Bool {
        switch (lhs, rhs) {
        case (.notFound(let lhsUserID), .notFound(let rhsUserID)):
            lhsUserID == rhsUserID

        case (.unknown(let lhsError), .unknown(let rhsError)):
            lhsError?.localizedDescription == rhsError?.localizedDescription

        default:
            false
        }
    }

}
