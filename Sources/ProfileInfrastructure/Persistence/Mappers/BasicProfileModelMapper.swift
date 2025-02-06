//
//  BasicProfileModelMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 24/01/2025.
//

import Foundation
import ProfileApplication

struct BasicProfileModelMapper {

    private init() {}

    static func map(
        from input: CreateBasicProfileInput
    ) -> BasicProfileModel {
        BasicProfileModel(
            userID: input.userID,
            displayName: input.displayName,
            birthDate: input.birthDate
        )
    }

}
