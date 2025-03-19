//
//  GenderDTOMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation
import ReferenceDataDomain

struct GenderDTOMapper {

    private init() {}

    static func map(from gender: Gender) -> GenderDTO {
        GenderDTO(
            id: gender.id,
            code: gender.code,
            name: gender.name,
            nameKey: gender.nameKey
        )
    }

}
