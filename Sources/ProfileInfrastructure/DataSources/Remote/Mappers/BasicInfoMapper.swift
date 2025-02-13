//
//  BasicInfoMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 11/02/2025.
//

import Foundation
import ProfileDomain

struct BasicInfoMapper {

    private init() {}

    static func map(from model: BasicInfoModel) throws -> BasicInfo {
        BasicInfo(
            id: try model.requireID(),
            userID: model.userID,
            profileID: model.profileID,
            genderID: model.genderID,
            countryID: model.countryID,
            location: model.location,
            homeTown: model.homeTown,
            workplace: model.workplace
        )
    }

}
