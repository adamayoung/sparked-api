//
//  StarSignDTOMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 18/03/2025.
//

import Foundation
import ReferenceDataDomain

struct StarSignDTOMapper {

    private init() {}

    static func map(from starSign: StarSign) -> StarSignDTO {
        StarSignDTO(
            id: starSign.id,
            name: starSign.name,
            nameKey: starSign.nameKey,
            glyph: starSign.glyph
        )
    }

}
