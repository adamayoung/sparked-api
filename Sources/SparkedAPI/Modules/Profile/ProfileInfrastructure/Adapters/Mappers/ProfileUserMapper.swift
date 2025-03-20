//
//  ProfileUserMapper.swift
//  SparkedAPI
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation
import IdentityApplication
import ProfileDomain

struct ProfileUserMapper {

    private init() {}

    static func map(from dto: IdentityApplication.UserDTO) -> ProfileDomain.User {
        User(
            id: dto.id,
            email: dto.email
        )
    }

}
