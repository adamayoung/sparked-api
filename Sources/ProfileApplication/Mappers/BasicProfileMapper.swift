//
//  BasicProfileMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 06/02/2025.
//

import Foundation
import ProfileDomain

struct BasicProfileMapper {

    private init() {}

    static func map(from input: CreateBasicProfileInput) -> BasicProfile {
        BasicProfile(
            displayName: input.displayName,
            birthDate: input.birthDate,
            bio: input.bio,
            ownerID: input.ownerID
        )
    }

}
