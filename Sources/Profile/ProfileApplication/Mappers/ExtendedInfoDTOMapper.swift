//
//  ExtendedInfoDTOMapper.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation
import ProfileDomain

struct ExtendedInfoDTOMapper {

    private init() {}

    static func map(from extendedInfo: ExtendedInfo) -> ExtendedInfoDTO {
        ExtendedInfoDTO(
            id: extendedInfo.id,
            profileID: extendedInfo.profileID,
            height: extendedInfo.height,
            educationLevelID: extendedInfo.educationLevelID,
            starSignID: extendedInfo.starSignID
        )
    }

}
