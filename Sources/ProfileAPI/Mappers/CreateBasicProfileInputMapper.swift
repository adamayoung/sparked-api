//
//  CreateBasicProfileInputMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 30/01/2025.
//

import Foundation
import ProfileDomain

struct CreateBasicProfileInputMapper {

    private init() {}

    static func map(from dto: CreateBasicProfileDTO, userID: UUID) -> CreateBasicProfileInput {
        CreateBasicProfileInput(
            userID: userID,
            displayName: dto.displayName,
            birthDate: dto.birthDate
        )
    }

}
