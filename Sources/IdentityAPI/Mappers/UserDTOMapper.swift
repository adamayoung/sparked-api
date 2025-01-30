//
//  UserDTOMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 29/01/2025.
//

import Foundation
import IdentityDomain
import IdentityEntities

struct UserDTOMapper {

    private init() {}

    static func map(from user: User) -> UserDTO {
        UserDTO(
            id: user.id,
            firstName: user.firstName,
            familyName: user.familyName,
            email: user.email,
            isVerified: user.isVerified
        )
    }

}
