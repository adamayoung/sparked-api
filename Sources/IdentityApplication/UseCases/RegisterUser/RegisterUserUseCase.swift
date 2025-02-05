//
//  RegisterUserUseCase.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation

package protocol RegisterUserUseCase {

    @discardableResult
    func execute(input: RegisterUserInput) async throws(RegisterUserError) -> UserDTO

}
