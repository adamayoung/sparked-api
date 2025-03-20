//
//  ProfileInterestMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation
import ProfileDomain

struct ProfileInterestMapper {

    private init() {}

    static func map(from model: ProfileInterestModel) throws -> ProfileInterest {
        try ProfileInterest(
            id: model.requireID(),
            profileID: model.profileID,
            interestID: model.interestID,
            ownerID: model.ownerID
        )
    }

}
