//
//  RegisterUserInputMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 29/01/2025.
//

import Foundation
import IdentityDomain

struct RegisterUserInputMapper {

    private init() {}

    static func map(from dto: RegisterUserDTO) -> RegisterUserInput {
        RegisterUserInput(
            firstName: dto.firstName,
            familyName: dto.familyName,
            email: dto.email,
            password: dto.password
        )
    }

}
