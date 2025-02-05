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

    func create(input: RegisterUserInput) async throws(RegisterUserError) -> User

    func fetch(byID id: User.ID) async throws(FetchUserError) -> User

    func fetch(byEmail email: String) async throws(FetchUserError) -> User

    func authenticate(email: String, password: String) async throws(AuthenticateUserError) -> User

}
