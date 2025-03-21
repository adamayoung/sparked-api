//
//  ExtendedInfoMapper.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation
import ProfileDomain

struct ExtendedInfoMapper {

    private init() {}

    static func map(from input: CreateExtendedInfoInput, ownerID: User.ID) -> ExtendedInfo {
        ExtendedInfo(
            profileID: input.profileID,
            height: input.height,
            educationLevelID: input.educationLevelID,
            starSignID: input.starSignID,
            ownerID: ownerID
        )
    }

}
