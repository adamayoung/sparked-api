//
//  AuthenticateUserUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 24/01/2025.
//

import Foundation
import IdentityEntities

package protocol AuthenticateUserUseCase {

    func execute(credential: UserCredential) async throws(AuthenticateUserError) -> User

}
