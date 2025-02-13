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

    static func map(from input: CreateBasicInfoInput) -> BasicInfo {
        BasicInfo(
            userID: input.userID,
            profileID: input.profileID,
            genderID: input.genderID,
            countryID: input.countryID,
            location: input.location,
            homeTown: input.homeTown,
            workplace: input.workplace
        )
    }

}
