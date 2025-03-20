//
//  CreateBasicInfoInputMapper.swift
//  SparkedAPI
//
//  Created by Adam Young on 12/02/2025.
//

import Foundation
import ProfileApplication

struct CreateBasicInfoInputMapper {

    private init() {}

    static func map(
        from requestModel: CreateBasicInfoRequestModel,
        profileID: BasicProfileDTO.ID
    ) -> CreateBasicInfoInput {
        CreateBasicInfoInput(
            profileID: profileID,
            genderID: requestModel.genderID,
            countryID: requestModel.countryID,
            location: requestModel.location,
            homeTown: requestModel.homeTown,
            workplace: requestModel.workplace
        )
    }

}
