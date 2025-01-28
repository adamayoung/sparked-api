//
//  UserCredentialMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 28/01/2025.
//

import Foundation
import IdentityDomain

struct UserCredentialMapper {

    private init() {}

    static func map(from dto: UserCredentialDTO) -> UserCredential {
        UserCredential(
            email: dto.email,
            password: dto.password
        )
    }

}
