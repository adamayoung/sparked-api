//
//  InterestResponseModelMapper.swift
//  SparkedAPI
//
//  Created by Adam Young on 13/03/2025.
//

import Foundation
import ReferenceDataApplication

struct InterestResponseModelMapper {

    private init() {}

    static func map(from dto: InterestDTO) -> InterestResponseModel {
        InterestResponseModel(
            id: dto.id,
            name: dto.name,
            nameKey: dto.nameKey,
            glyph: dto.glyph
        )
    }

}
