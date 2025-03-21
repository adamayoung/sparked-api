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

    static func map(from model: ExtendedInfoModel) throws -> ExtendedInfo {
        try ExtendedInfo(
            id: model.requireID(),
            profileID: model.profileID,
            height: model.height,
            educationLevelID: model.educationLevelID,
            starSignID: model.starSignID,
            ownerID: model.ownerID
        )
    }

}
