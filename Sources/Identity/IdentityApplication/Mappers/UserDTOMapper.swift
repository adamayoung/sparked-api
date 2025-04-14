//
//  UserDTOMapper.swift
//  SparkedAPI
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation
import IdentityDomain

struct UserDTOMapper {

    private init() {}

    static func map(from user: User, roles: [Role]) -> UserDTO {
        let roleDTOs = roles.map(RoleDTOMapper.map)

        return UserDTO(
            id: user.id,
            firstName: user.firstName,
            familyName: user.familyName,
            fullName: user.fullName,
            email: user.email,
            roles: roleDTOs,
            isVerified: user.isVerified,
            isActive: user.isActive
        )
    }

}
