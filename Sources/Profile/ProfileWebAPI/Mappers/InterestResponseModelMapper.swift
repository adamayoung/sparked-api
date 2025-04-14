//
//  InterestResponseModelMapper.swift
//  SparkedAPI
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation
import ProfileApplication

struct InterestResponseModelMapper {

    private init() {}

    static func map(from dto: ProfileInterestDTO) -> InterestResponseModel {
        InterestResponseModel(
            id: dto.interestID,
            name: dto.name,
            glyph: dto.glyph
        )
    }

}
