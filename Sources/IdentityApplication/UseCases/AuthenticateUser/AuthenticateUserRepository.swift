//
//  AuthenticateUserRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 24/01/2025.
//

import Foundation
import IdentityDomain

package protocol AuthenticateUserRepository {

    func fetchForAuthentication(byEmail email: String) async throws(AuthenticateUserError) -> User

}
