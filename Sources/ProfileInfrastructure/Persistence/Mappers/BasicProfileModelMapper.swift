//
//  BasicProfileModelMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 24/01/2025.
//

import Foundation
import ProfileDomain

struct BasicProfileModelMapper {

    private init() {}

    static func map(from basicProfile: BasicProfile) -> BasicProfileModel {
        BasicProfileModel(
            id: basicProfile.id,
            userID: basicProfile.userID,
            displayName: basicProfile.displayName,
            birthDate: basicProfile.birthDate
        )
    }

}
