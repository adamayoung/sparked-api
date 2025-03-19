//
//  StarSignMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 18/03/2025.
//

import Foundation
import ReferenceDataDomain

struct StarSignMapper {

    private init() {}

    static func map(from model: StarSignModel) throws -> StarSign {
        try StarSign(
            id: model.requireID(),
            name: model.name,
            nameKey: model.nameKey,
            glyph: model.glyph,
            index: model.index
        )
    }

}
