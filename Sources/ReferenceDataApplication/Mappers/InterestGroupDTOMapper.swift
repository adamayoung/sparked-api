//
//  InterestGroupDTOMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 12/03/2025.
//

import Foundation
import ReferenceDataDomain

struct InterestGroupDTOMapper {

    private init() {}

    static func map(from interestGroup: InterestGroup) -> InterestGroupDTO {
        InterestGroupDTO(
            id: interestGroup.id,
            name: interestGroup.name,
            nameKey: interestGroup.nameKey
        )
    }

}
