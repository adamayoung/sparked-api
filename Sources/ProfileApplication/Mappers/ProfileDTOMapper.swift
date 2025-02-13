//
//  ProfileDTOMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 12/02/2025.
//

import Foundation
import ProfileDomain

struct ProfileDTOMapper {

    private init() {}

    static func map(from basicProfile: BasicProfile, basicInfo: BasicInfo) -> ProfileDTO {
        ProfileDTO(
            id: basicProfile.id,
            userID: basicProfile.userID,
            displayName: basicProfile.displayName,
            birthDate: basicProfile.birthDate,
            age: basicProfile.age,
            genderID: basicInfo.genderID,
            countryID: basicInfo.countryID,
            location: basicInfo.location,
            homeTown: basicInfo.homeTown,
            workplace: basicInfo.workplace
        )
    }

}
