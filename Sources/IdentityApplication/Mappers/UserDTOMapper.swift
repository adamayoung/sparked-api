//
//  UserDTOMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation
import IdentityDomain

struct UserDTOMapper {

    private init() {}

    static func map(from user: User) -> UserDTO {
        UserDTO(
            id: user.id,
            firstName: user.firstName,
            familyName: user.familyName,
            fullName: user.fullName,
            email: user.email,
            isVerified: user.isVerified,
            isActive: user.isActive
        )
    }

}
