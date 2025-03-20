//
//  CreateExtendedInfoInputMapper.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation
import ProfileApplication

struct CreateExtendedInfoInputMapper {

    private init() {}

    static func map(
        from requestModel: CreateExtendedInfoRequestModel,
        profileID: BasicProfileDTO.ID
    ) -> CreateExtendedInfoInput {
        CreateExtendedInfoInput(
            profileID: profileID,
            height: requestModel.height,
            educationLevelID: requestModel.educationLevelID,
            starSignID: requestModel.starSignID
        )
    }

}
