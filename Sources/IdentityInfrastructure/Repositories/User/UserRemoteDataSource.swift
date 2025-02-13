//
//  UserRemoteDataSource.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation
import IdentityApplication
import IdentityDomain

protocol UserRemoteDataSource {

    func create(_ user: User) async throws(UserRepositoryError)

    func fetch(byID id: User.ID) async throws(UserRepositoryError) -> User

    func fetch(byEmail email: String) async throws(UserRepositoryError) -> User

}
