//
//  AddProfileInterestInputMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation
import ProfileApplication

struct AddProfileInterestInputMapper {

    private init() {}

    static func map(
        from requestModel: AddProfileInterestRequestModel,
        profileID: UUID
    ) -> AddProfileInterestInput {
        AddProfileInterestInput(
            profileID: profileID,
            interestID: requestModel.interestID
        )
    }

}
