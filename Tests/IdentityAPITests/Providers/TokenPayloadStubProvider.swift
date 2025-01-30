//
//  TokenPayloadStubProvider.swift
//  AdamDateApp
//
//  Created by Adam Young on 29/01/2025.
//

import AdamDateAuth
import Foundation
import IdentityAPI
import IdentityEntities

final class TokenPayloadStubProvider: TokenPayloadProvider, @unchecked Sendable {

    var tokenPayloadResult: TokenPayload?
    private(set) var lastTokenPayloadUser: User?

    init() {}

    func tokenPayload(for user: User) -> TokenPayload {
        lastTokenPayloadUser = user

        guard let tokenPayloadResult else {
            fatalError("tokenPayloadResult not set")
        }

        return tokenPayloadResult
    }

}
