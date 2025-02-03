//
//  TokenPayloadAdapter.swift
//  AdamDateApp
//
//  Created by Adam Young on 28/01/2025.
//

import AdamDateAuth
import Foundation
import IdentityAPI
import IdentityDomain

final class TokenPayloadAdapter: TokenPayloadProvider {

    private let jwtConfiguration: JWTConfiguration

    init(jwtConfiguration: JWTConfiguration) {
        self.jwtConfiguration = jwtConfiguration
    }

    func tokenPayload(for user: User) -> TokenPayload {
        TokenPayload(
            subject: user.id.uuidString,
            email: user.email,
            fullName: user.fullName,
            configuration: jwtConfiguration
        )
    }

}
