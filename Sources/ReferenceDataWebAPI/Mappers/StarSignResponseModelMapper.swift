//
//  StarSignResponseModelMapper.swift
//  SparkedAPI
//
//  Created by Adam Young on 18/03/2025.
//

import Foundation
import ReferenceDataApplication

struct StarSignResponseModelMapper {

    private init() {}

    static func map(from dto: StarSignDTO) -> StarSignResponseModel {
        StarSignResponseModel(
            id: dto.id,
            name: dto.name,
            nameKey: dto.nameKey,
            glyph: dto.glyph
        )
    }

}
