//
//  RoleModelMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 19/03/2025.
//

import Foundation
import IdentityDomain

struct RoleModelMapper {

    private init() {}

    static func map(from role: Role) -> RoleModel {
        RoleModel(
            id: role.id,
            name: role.name,
            code: role.code,
            description: role.description
        )
    }

}
