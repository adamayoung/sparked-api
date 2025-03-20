//
//  BasicInfoResponseModelMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 12/02/2025.
//

import Foundation
import ProfileApplication

struct BasicInfoResponseModelMapper {

    private init() {}

    static func map(from dto: BasicInfoDTO) -> BasicInfoResponseModel {
        BasicInfoResponseModel(
            id: dto.id,
            genderID: dto.genderID,
            countryID: dto.countryID,
            location: dto.location,
            homeTown: dto.homeTown,
            workplace: dto.workplace
        )
    }

}
