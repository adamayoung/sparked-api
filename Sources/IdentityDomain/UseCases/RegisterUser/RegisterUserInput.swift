//
//  RegisterUserInput.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation

package struct RegisterUserInput {

    package let firstName: String
    package let lastName: String
    package let email: String
    package let password: String
    package let isVerified: Bool
    package let isAdmin: Bool

    package init(
        firstName: String,
        lastName: String,
        email: String,
        password: String,
        isVerified: Bool = false,
        isAdmin: Bool = false
    ) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        self.isVerified = isVerified
        self.isAdmin = isAdmin
    }

}
