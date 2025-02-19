//
//  IdentityAdapterFactory.swift
//  AdamDateApp
//
//  Created by Adam Young on 19/02/2025.
//

import AdamDateAuth
import Foundation
import IdentityApplication
import IdentityPresentation

final class IdentityAdapterFactory {

    private init() {}

    static func makePasswordHasherService(
        hasher: some PasswordHasher
    ) -> some PasswordHasherService {
        PasswordHasherAdapter(hasher: hasher)
    }

    static func makeTokenPayloadService(
        jwtConfiguration: JWTConfiguration
    ) -> some TokenPayloadService {
        TokenPayloadAdapter(jwtConfiguration: jwtConfiguration)
    }

}
