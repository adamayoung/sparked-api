//
//  RegisterUserInputMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 29/01/2025.
//

import Foundation
import IdentityDomain
import IdentityEntities

struct RegisterUserInputMapper {

    private init() {}

    static func map(from dto: RegisterUserDTO) -> RegisterUserInput {
        RegisterUserInput(
            firstName: dto.firstName,
            lastName: dto.lastName,
            email: dto.email,
            password: dto.password
        )
    }

}
