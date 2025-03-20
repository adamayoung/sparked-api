//
//  RegisterUserInput+Mock.swift
//  AdamDateApp
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation
import IdentityApplication
import Testing

extension RegisterUserInput {

    static func mock(
        firstName: String = "Dave",
        familyName: String = "Smith",
        email: String = "dave@email.com",
        password: String = "Password123",
        isVerified: Bool = true,
        roles: [String] = ["USER"]
    ) -> RegisterUserInput {
        RegisterUserInput(
            firstName: firstName,
            familyName: familyName,
            email: email,
            password: password,
            isVerified: isVerified,
            roles: roles
        )
    }

}
