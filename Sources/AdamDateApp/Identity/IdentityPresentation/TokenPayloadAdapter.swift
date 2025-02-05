//
//  TokenPayloadAdapter.swift
//  AdamDateApp
//
//  Created by Adam Young on 28/01/2025.
//

import AdamDateAuth
import Foundation
import IdentityApplication
import IdentityPresentation

final class TokenPayloadAdapter: TokenPayloadProvider {

    private let jwtConfiguration: JWTConfiguration

    init(jwtConfiguration: JWTConfiguration) {
        self.jwtConfiguration = jwtConfiguration
    }

    func tokenPayload(for dto: UserDTO) -> TokenPayload {
        TokenPayload(
            subject: dto.id.uuidString,
            email: dto.email,
            fullName: dto.fullName,
            configuration: jwtConfiguration
        )
    }

}
