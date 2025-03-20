//
//  ProfileInterestMapper.swift
//  SparkedAPI
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation
import ProfileDomain
import ReferenceDataApplication

struct ProfileInterestMapper {

    private init() {}

    static func map(from dto: ReferenceDataApplication.InterestDTO) -> ProfileDomain.Interest {
        Interest(
            id: dto.id,
            name: dto.name,
            glyph: dto.glyph
        )
    }

}
