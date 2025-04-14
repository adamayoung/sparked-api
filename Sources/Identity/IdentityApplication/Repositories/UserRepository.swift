//
//  UserRepository.swift
//  SparkedAPI
//
//  Created by Adam Young on 10/02/2025.
//

import Foundation
import IdentityDomain

package protocol UserRepository {

    func create(_ user: User, withRoles roles: [Role]) async throws(UserRepositoryError)

    func fetch(byID id: User.ID) async throws(UserRepositoryError) -> User

    func fetch(byEmail email: String) async throws(UserRepositoryError) -> User

}

package enum UserRepositoryError: Error, Equatable {

    case notFound
    case duplicateUserID
    case duplicateEmail
    case roleNotFound
    case unknown((any Error)? = nil)

    package static func == (lhs: UserRepositoryError, rhs: UserRepositoryError) -> Bool {
        switch (lhs, rhs) {
        case (.notFound, .notFound):
            return true
        case (.duplicateUserID, .duplicateUserID):
            return true
        case (.duplicateEmail, .duplicateEmail):
            return true
        case (.roleNotFound, .roleNotFound):
            return true
        case (.unknown(let lhsError), .unknown(let rhsError)):
            return lhsError?.localizedDescription == rhsError?.localizedDescription
        default:
            return false
        }
    }

}
