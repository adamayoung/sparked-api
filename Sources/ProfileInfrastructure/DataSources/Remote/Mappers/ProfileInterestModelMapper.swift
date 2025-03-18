//
//  ProfileInterestModelMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation
import ProfileDomain

struct ProfileInterestModelMapper {

    private init() {}

    static func map(from profileInterest: ProfileInterest) -> ProfileInterestModel {
        ProfileInterestModel(
            id: profileInterest.id,
            userID: profileInterest.userID,
            profileID: profileInterest.profileID,
            interestID: profileInterest.interestID
        )
    }

}
