//
//  TokenPayloadAdapter.swift
//  SparkedAPI
//
//  Created by Adam Young on 28/01/2025.
//

import AuthKit
import Foundation
import IdentityApplication
import IdentityWebAPI

final class TokenPayloadAdapter: TokenPayloadService {

    private let jwtConfiguration: JWTConfiguration

    init(jwtConfiguration: JWTConfiguration) {
        self.jwtConfiguration = jwtConfiguration
    }

    func tokenPayload(for dto: UserDTO) -> TokenPayload {
        TokenPayload(
            subject: dto.id.uuidString,
            email: dto.email,
            fullName: dto.fullName,
            roles: dto.roles.map(\.code),
            configuration: jwtConfiguration
        )
    }

}
