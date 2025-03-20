//
//  BasicProfileDTOMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation
import ProfileDomain

struct BasicProfileDTOMapper {

    private init() {}

    static func map(from basicProfile: BasicProfile) -> BasicProfileDTO {
        BasicProfileDTO(
            id: basicProfile.id,
            displayName: basicProfile.displayName,
            birthDate: basicProfile.birthDate,
            age: basicProfile.age,
            bio: basicProfile.bio
        )
    }

}
