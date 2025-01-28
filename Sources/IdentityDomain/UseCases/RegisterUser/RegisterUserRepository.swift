//
//  RegisterUserRepository.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation
import IdentityEntities

package protocol RegisterUserRepository {

    func create(input: RegisterUserInput, isVerified: Bool) async throws(RegisterUserError) -> User

}
