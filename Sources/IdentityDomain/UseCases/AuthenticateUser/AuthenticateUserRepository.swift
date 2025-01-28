//
//  AuthenticateUserRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 24/01/2025.
//

import Foundation
import IdentityEntities

package protocol AuthenticateUserRepository {

    func authenticate(
        email: String,
        password: String
    ) async throws(AuthenticateUserError) -> User

}
