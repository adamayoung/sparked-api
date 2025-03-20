//
//  BasicInfoModelMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 11/02/2025.
//

import Foundation
import ProfileDomain

struct BasicInfoModelMapper {

    private init() {}

    static func map(from basicInfo: BasicInfo) -> BasicInfoModel {
        BasicInfoModel(
            id: basicInfo.id,
            profileID: basicInfo.profileID,
            genderID: basicInfo.genderID,
            countryID: basicInfo.countryID,
            location: basicInfo.location,
            homeTown: basicInfo.homeTown,
            workplace: basicInfo.workplace,
            ownerID: basicInfo.ownerID
        )
    }

}
