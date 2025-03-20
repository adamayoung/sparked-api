//
//  CreateBasicProfileInputMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 30/01/2025.
//

import Foundation
import ProfileApplication

struct CreateBasicProfileInputMapper {

    private init() {}

    static func map(
        from requestModel: CreateBasicProfileRequestModel,
        userID: UUID
    ) -> CreateBasicProfileInput {
        CreateBasicProfileInput(
            displayName: requestModel.displayName,
            birthDate: requestModel.birthDate,
            bio: requestModel.bio,
            ownerID: userID
        )
    }

}
