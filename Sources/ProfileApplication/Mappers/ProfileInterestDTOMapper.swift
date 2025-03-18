//
//  ProfileInterestDTOMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation
import ProfileDomain

struct ProfileInterestDTOMapper {

    private init() {}

    static func map(
        from profileInterest: ProfileInterest,
        interest: Interest
    ) -> ProfileInterestDTO {
        ProfileInterestDTO(
            id: profileInterest.id,
            userID: profileInterest.userID,
            profileID: profileInterest.profileID,
            interestID: interest.id,
            name: interest.name,
            glyph: interest.glyph
        )
    }

}
