//
//  UserRemoteDataSource.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation
import IdentityApplication
import IdentityDomain

package protocol UserRemoteDataSource {

    func create(_ user: User) async throws(RegisterUserError)

    func fetch(byID id: User.ID) async throws(FetchUserError) -> User

    func fetch(byEmail email: String) async throws(FetchUserError) -> User

}
