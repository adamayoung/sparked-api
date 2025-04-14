//
//  UserCredentialMapper.swift
//  SparkedAPI
//
//  Created by Adam Young on 28/01/2025.
//

import Foundation
import IdentityApplication

struct UserCredentialMapper {

    private init() {}

    static func map(from requestModel: UserCredentialRequestModel) -> UserCredential {
        UserCredential(
            email: requestModel.email,
            password: requestModel.password
        )
    }

}
