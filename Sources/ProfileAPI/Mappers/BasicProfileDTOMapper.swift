//
//  BasicProfileDTOMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 30/01/2025.
//

import Foundation
import ProfileDomain

struct BasicProfileDTOMapper {

    private init() {}

    static func map(from model: BasicProfile) -> BasicProfileDTO {
        BasicProfileDTO(
            id: model.id,
            displayName: model.displayName
        )
    }

}
