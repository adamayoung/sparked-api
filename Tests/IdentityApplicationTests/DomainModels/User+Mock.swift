//
//  User+Mock.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation
import IdentityDomain
import Testing

extension User {

    static func mock(
        id: UUID? = UUID(uuidString: "5DBFF1D4-C857-4B45-AD38-549628449992"),
        firstName: String = "Dave",
        familyName: String = "Smith",
        email: String = "dave@email.com",
        passwordHash: String = "Password123",
        isVerified: Bool = true,
        isActive: Bool = true
    ) throws -> User {
        try User(
            id: #require(id),
            firstName: firstName,
            familyName: familyName,
            email: email,
            passwordHash: passwordHash,
            isVerified: isVerified,
            isActive: isActive
        )
    }

}
