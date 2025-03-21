//
//  ProfileEducationLevelMapper.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation
import ProfileDomain
import ReferenceDataApplication

struct ProfileEducationLevelMapper {

    private init() {}

    static func map(
        from dto: ReferenceDataApplication.EducationLevelDTO
    ) -> ProfileDomain.EducationLevel {
        EducationLevel(
            id: dto.id,
            name: dto.name
        )
    }

}
