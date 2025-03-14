//
//  InterestGroupResponseModelMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 13/03/2025.
//

import Foundation
import ReferenceDataApplication

struct InterestGroupResponseModelMapper {

    private init() {}

    static func map(from dto: InterestGroupDTO) -> InterestGroupResponseModel {
        InterestGroupResponseModel(
            id: dto.id,
            name: dto.name
        )
    }

    static func map(from dto: InterestGroupAggregateDTO) -> InterestGroupResponseModel {
        let interests = dto.interests.map(InterestResponseModelMapper.map)

        return InterestGroupResponseModel(
            id: dto.id,
            name: dto.name,
            interests: interests
        )
    }

}
