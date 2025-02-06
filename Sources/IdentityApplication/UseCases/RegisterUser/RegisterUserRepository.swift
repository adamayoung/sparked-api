//
//  RegisterUserRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation
import IdentityDomain

package protocol RegisterUserRepository {

    func create(_ user: User) async throws(RegisterUserError)

}
