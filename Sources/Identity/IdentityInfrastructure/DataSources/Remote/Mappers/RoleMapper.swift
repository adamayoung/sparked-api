//
//  RoleMapper.swift
//  SparkedAPI
//
//  Created by Adam Young on 19/03/2025.
//

import Foundation
import IdentityDomain

struct RoleMapper {

    private init() {}

    static func map(from model: RoleModel) throws -> Role {
        try Role(
            id: model.requireID(),
            code: model.code,
            name: model.name,
            description: model.description
        )
    }

}
