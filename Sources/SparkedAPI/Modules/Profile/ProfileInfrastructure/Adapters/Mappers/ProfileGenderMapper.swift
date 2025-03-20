//
//  ProfileGenderMapper.swift
//  SparkedAPI
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation
import ProfileDomain
import ReferenceDataApplication

struct ProfileGenderMapper {

    private init() {}

    static func map(from dto: ReferenceDataApplication.GenderDTO) -> ProfileDomain.Gender {
        Gender(
            id: dto.id,
            code: dto.code,
            name: dto.name
        )
    }

}
