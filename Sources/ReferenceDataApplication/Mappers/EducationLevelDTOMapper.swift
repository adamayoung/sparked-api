//
//  EducationLevelDTOMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 18/03/2025.
//

import Foundation
import ReferenceDataDomain

struct EducationLevelDTOMapper {

    private init() {}

    static func map(from educationLevel: EducationLevel) -> EducationLevelDTO {
        EducationLevelDTO(
            id: educationLevel.id,
            name: educationLevel.name,
            nameKey: educationLevel.nameKey
        )
    }

}
