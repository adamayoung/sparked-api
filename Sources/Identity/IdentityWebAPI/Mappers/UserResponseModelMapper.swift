//
//  UserResponseModelMapper.swift
//  SparkedAPI
//
//  Created by Adam Young on 29/01/2025.
//

import Foundation
import IdentityApplication

struct UserResponseModelMapper {

    private init() {}

    static func map(from dto: UserDTO) -> UserResponseModel {
        UserResponseModel(
            id: dto.id,
            firstName: dto.firstName,
            familyName: dto.familyName,
            email: dto.email,
            roles: dto.roles.map(\.code),
            isVerified: dto.isVerified
        )
    }

}
