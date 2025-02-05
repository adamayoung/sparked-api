//
//  AuthenticateUserUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 24/01/2025.
//

import Foundation

package protocol AuthenticateUserUseCase {

    func execute(credential: UserCredential) async throws(AuthenticateUserError) -> UserDTO

}
