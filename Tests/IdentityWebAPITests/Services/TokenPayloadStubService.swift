//
//  TokenPayloadStubService.swift
//  AdamDateApp
//
//  Created by Adam Young on 29/01/2025.
//

import AuthKit
import Foundation
import IdentityApplication
import IdentityWebAPI

final class TokenPayloadStubService: TokenPayloadService, @unchecked Sendable {

    var tokenPayloadResult: TokenPayload?
    private(set) var lastTokenPayloadUser: UserDTO?

    init() {}

    func tokenPayload(for dto: UserDTO) -> TokenPayload {
        lastTokenPayloadUser = dto

        guard let tokenPayloadResult else {
            fatalError("tokenPayloadResult not set")
        }

        return tokenPayloadResult
    }

}
