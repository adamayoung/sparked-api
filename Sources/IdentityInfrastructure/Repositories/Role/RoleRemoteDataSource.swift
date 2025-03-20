//
//  RoleRemoteDataSource.swift
//  AdamDateApp
//
//  Created by Adam Young on 19/03/2025.
//

import Foundation
import IdentityApplication
import IdentityDomain

protocol RoleRemoteDataSource {

    func create(_ role: Role) async throws(RoleRepositoryError)

    func addRole(_ role: Role, toUser user: User) async throws(RoleRepositoryError)

    func addRoles(_ roles: [Role], toUser user: User) async throws(RoleRepositoryError)

    func fetchAll() async throws(RoleRepositoryError) -> [Role]

    func fetchAll(forUserID userID: User.ID) async throws(RoleRepositoryError) -> [Role]

    func fetch(byID id: Role.ID) async throws(RoleRepositoryError) -> Role

    func fetch(byCode code: String) async throws(RoleRepositoryError) -> Role

    func delete(byID id: Role.ID) async throws(RoleRepositoryError)

}
