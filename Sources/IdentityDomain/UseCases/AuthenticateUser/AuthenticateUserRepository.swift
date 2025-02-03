//
//  AuthenticateUserRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 24/01/2025.
//

import Foundation

package protocol AuthenticateUserRepository {

    func authenticate(
        email: String,
        password: String
    ) async throws(AuthenticateUserError) -> User

}
