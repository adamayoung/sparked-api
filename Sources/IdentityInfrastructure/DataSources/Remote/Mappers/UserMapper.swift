//
//  UserMapper.swift
//  SparkedAPI
//
//  Created by Adam Young on 23/01/2025.
//

import Foundation
import IdentityDomain

struct UserMapper {

    private init() {}

    static func map(from model: UserModel) throws -> User {
        try User(
            id: model.requireID(),
            firstName: model.firstName,
            familyName: model.familyName,
            email: model.email,
            passwordHash: model.password,
            isVerified: model.isVerified,
            isActive: model.deletedAt == nil
        )
    }

}
