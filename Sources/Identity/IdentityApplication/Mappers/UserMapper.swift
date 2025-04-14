//
//  UserRegistrationMapper.swift
//  SparkedAPI
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation
import IdentityDomain

struct UserMapper {

    private init() {}

    static func map(
        from input: RegisterUserInput,
        using passwordHasherService: some PasswordHasherService
    ) throws -> User {
        try User(
            firstName: input.firstName,
            familyName: input.familyName,
            email: input.email,
            passwordHash: input.passwordHash(using: passwordHasherService),
            isVerified: input.isVerified
        )
    }

}
