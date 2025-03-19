//
//  InterestMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 12/03/2025.
//

import Foundation
import ReferenceDataDomain

struct InterestMapper {

    private init() {}

    static func map(from model: InterestModel) throws -> Interest {
        try Interest(
            id: model.requireID(),
            interestGroupID: model.interestGroup.requireID(),
            name: model.name,
            nameKey: model.nameKey,
            glyph: model.glyph
        )
    }

}
