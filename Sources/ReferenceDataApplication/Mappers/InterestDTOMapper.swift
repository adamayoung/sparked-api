//
//  InterestDTOMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 12/03/2025.
//

import Foundation
import ReferenceDataDomain

struct InterestDTOMapper {

    private init() {}

    static func map(from interest: Interest) -> InterestDTO {
        InterestDTO(
            id: interest.id,
            name: interest.name,
            nameKey: interest.nameKey,
            glyph: interest.glyph
        )
    }

}
