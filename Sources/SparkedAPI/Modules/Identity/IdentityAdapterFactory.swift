//
//  IdentityAdapterFactory.swift
//  SparkedAPI
//
//  Created by Adam Young on 19/02/2025.
//

import AuthKit
import Foundation
import IdentityApplication
import IdentityWebAPI

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
