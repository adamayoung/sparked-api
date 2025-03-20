//
//  TokenPayload+Stub.swift
//  AdamDateApp
//
//  Created by Adam Young on 30/01/2025.
//

import AuthKit
import Foundation
import Testing

extension TokenPayload {

    package static func stub(
        issuer: String = "test",
        audience: String = "test",
        subject: UUID? = UUID(uuidString: "DE663275-F75E-4D6C-984F-8F3B0D637021"),
        email: String = "email@example.com",
        fullName: String = "John Doe",
        roles: [String] = ["USER"],
        expiration: TimeInterval = 10000
    ) throws -> TokenPayload {
        let configuration = JWTConfiguration(
            issuer: issuer,
            audience: audience,
            expiration: expiration
        )

        return try TokenPayload(
            subject: #require(subject?.uuidString),
            email: email,
            fullName: fullName,
            roles: roles,
            configuration: configuration,
            dateProvider: Date.init
        )
    }

}
