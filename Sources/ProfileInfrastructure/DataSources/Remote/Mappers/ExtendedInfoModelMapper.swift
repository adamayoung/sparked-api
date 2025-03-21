//
//  ExtendedInfoModelMapper.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation
import ProfileDomain

struct ExtendedInfoModelMapper {

    private init() {}

    static func map(from extendedInfo: ExtendedInfo) -> ExtendedInfoModel {
        ExtendedInfoModel(
            id: extendedInfo.id,
            profileID: extendedInfo.profileID,
            height: extendedInfo.height,
            educationLevelID: extendedInfo.educationLevelID,
            starSignID: extendedInfo.starSignID,
            ownerID: extendedInfo.ownerID
        )
    }

}
