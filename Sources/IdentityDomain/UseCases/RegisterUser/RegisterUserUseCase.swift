//
//  RegisterUserUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation
import IdentityEntities

package protocol RegisterUserUseCase {

    @discardableResult
    func execute(input: RegisterUserInput) async throws(RegisterUserError) -> User

}
