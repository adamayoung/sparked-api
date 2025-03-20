//
//  RoleDTOMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 19/03/2025.
//

import Foundation
import IdentityDomain

struct RoleDTOMapper {

    private init() {}

    static func map(from role: Role) -> RoleDTO {
        RoleDTO(
            id: role.id,
            code: role.code,
            name: role.name,
            description: role.description
        )
    }

}
