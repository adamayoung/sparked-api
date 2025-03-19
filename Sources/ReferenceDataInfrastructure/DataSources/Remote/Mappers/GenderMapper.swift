//
//  GenderMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation
import ReferenceDataDomain

struct GenderMapper {

    private init() {}

    static func map(from model: GenderModel) throws -> Gender {
        try Gender(
            id: model.requireID(),
            code: model.code,
            name: model.name,
            nameKey: model.nameKey
        )
    }

}
