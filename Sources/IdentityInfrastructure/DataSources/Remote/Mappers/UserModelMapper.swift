//
//  UserModelMapper.swift
//  SparkedAPI
//
//  Created by Adam Young on 23/01/2025.
//

import Foundation
import IdentityDomain

struct UserModelMapper {

    private init() {}

    static func map(from user: User) -> UserModel {
        UserModel(
            id: user.id,
            firstName: user.firstName,
            familyName: user.familyName,
            email: user.email,
            password: user.passwordHash,
            isVerified: user.isVerified
        )
    }

}
