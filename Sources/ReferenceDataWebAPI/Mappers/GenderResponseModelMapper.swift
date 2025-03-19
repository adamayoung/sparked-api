//
//  GenderResponseModelMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation
import ReferenceDataApplication

struct GenderResponseModelMapper {

    private init() {}

    static func map(from dto: GenderDTO) -> GenderResponseModel {
        GenderResponseModel(
            id: dto.id,
            code: dto.code,
            name: dto.name,
            nameKey: dto.nameKey
        )
    }

}
