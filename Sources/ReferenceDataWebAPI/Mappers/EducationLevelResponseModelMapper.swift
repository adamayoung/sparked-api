//
//  EducationLevelResponseModelMapper.swift
//  SparkedAPI
//
//  Created by Adam Young on 18/03/2025.
//

import Foundation
import ReferenceDataApplication

struct EducationLevelResponseModelMapper {

    private init() {}

    static func map(from dto: EducationLevelDTO) -> EducationLevelResponseModel {
        EducationLevelResponseModel(
            id: dto.id,
            name: dto.name,
            nameKey: dto.nameKey
        )
    }

}
