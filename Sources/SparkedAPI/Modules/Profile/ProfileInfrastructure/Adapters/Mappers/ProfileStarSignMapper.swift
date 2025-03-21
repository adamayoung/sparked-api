//
//  ProfileStarSignMapper.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation
import ProfileDomain
import ReferenceDataApplication

struct ProfileStarSignMapper {

    private init() {}

    static func map(
        from dto: ReferenceDataApplication.StarSignDTO
    ) -> ProfileDomain.StarSign {
        StarSign(
            id: dto.id,
            name: dto.name
        )
    }

}
