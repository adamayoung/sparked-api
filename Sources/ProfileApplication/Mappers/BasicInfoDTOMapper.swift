//
//  BasicInfoDTOMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation
import ProfileDomain

struct BasicInfoDTOMapper {

    private init() {}

    static func map(from basicInfo: BasicInfo) -> BasicInfoDTO {
        BasicInfoDTO(
            id: basicInfo.id,
            profileID: basicInfo.profileID,
            gender: GenderDTOMapper.map(from: basicInfo.gender),
            country: CountryDTOMapper.map(from: basicInfo.country),
            location: basicInfo.location,
            homeTown: basicInfo.homeTown,
            workplace: basicInfo.workplace
        )
    }

}
