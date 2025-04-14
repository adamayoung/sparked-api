//
//  ExtendedInfoResponseModelMapper.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation
import ProfileApplication

struct ExtendedInfoResponseModelMapper {

    private init() {}

    static func map(from dto: ExtendedInfoDTO) -> ExtendedInfoResponseModel {
        ExtendedInfoResponseModel(
            id: dto.id,
            height: dto.height,
            educationLevelID: dto.educationLevelID,
            starSignID: dto.starSignID
        )
    }

}
