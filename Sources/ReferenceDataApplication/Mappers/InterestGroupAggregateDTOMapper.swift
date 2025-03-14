//
//  InterestGroupAggregateDTOMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 12/03/2025.
//

import Foundation
import ReferenceDataDomain

struct InterestGroupAggregateDTOMapper {

    private init() {}

    static func map(
        from interestGroup: InterestGroup,
        interests: [Interest]
    ) -> InterestGroupAggregateDTO {
        let interestDTOs = interests.map(InterestDTOMapper.map)

        return InterestGroupAggregateDTO(
            id: interestGroup.id,
            name: interestGroup.name,
            interests: interestDTOs
        )
    }

}
