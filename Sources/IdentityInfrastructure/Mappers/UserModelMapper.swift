//
//  UserModelMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 23/01/2025.
//

import Foundation
import IdentityApplication
import IdentityDomain

struct UserModelMapper {

    private init() {}

    static func map(
        from input: RegisterUserInput,
        using passwordHasher: any PasswordHasherProvider
    ) throws -> UserModel {
        try UserModel(
            firstName: input.firstName,
            familyName: input.familyName,
            email: input.email,
            password: passwordHasher.hash(input.password),
            isVerified: input.isVerified
        )
    }

}
