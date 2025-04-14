//
//  RoleRepository.swift
//  SparkedAPI
//
//  Created by Adam Young on 19/03/2025.
//

import Foundation
import IdentityDomain

package protocol RoleRepository {

    func create(_ role: Role) async throws(RoleRepositoryError)

    func addRole(_ role: Role, toUser user: User) async throws(RoleRepositoryError)

    func addRoles(_ roles: [Role], toUser user: User) async throws(RoleRepositoryError)

    func fetchAll() async throws(RoleRepositoryError) -> [Role]

    func fetchAll(forUserID userID: User.ID) async throws(RoleRepositoryError) -> [Role]

    func fetch(byID id: Role.ID) async throws(RoleRepositoryError) -> Role

    func fetch(byCode code: String) async throws(RoleRepositoryError) -> Role

    func delete(byID id: Role.ID) async throws(RoleRepositoryError)

}

package enum RoleRepositoryError: Error, Equatable {

    case notFound
    case userNotFound
    case duplicateRoleID
    case duplicateRoleName
    case unknown((any Error)? = nil)

    package static func == (lhs: RoleRepositoryError, rhs: RoleRepositoryError) -> Bool {
        switch (lhs, rhs) {
        case (.notFound, .notFound):
            true
        case (.userNotFound, .userNotFound):
            true
        case (.duplicateRoleID, .duplicateRoleID):
            true
        case (.duplicateRoleName, .duplicateRoleName):
            true
        case (.unknown(let lhsError), .unknown(let rhsError)):
            lhsError?.localizedDescription == rhsError?.localizedDescription
        default:
            false
        }
    }

}
