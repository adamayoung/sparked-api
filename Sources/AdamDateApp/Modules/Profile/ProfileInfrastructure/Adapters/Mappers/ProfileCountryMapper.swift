//
//  ProfileCountryMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation
import ProfileDomain
import ReferenceDataApplication

struct ProfileCountryMapper {

    private init() {}

    static func map(from dto: ReferenceDataApplication.CountryDTO) -> ProfileDomain.Country {
        Country(
            id: dto.id,
            code: dto.code,
            name: dto.name
        )
    }

}
