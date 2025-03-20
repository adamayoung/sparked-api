//
//  EducationLevelMapper.swift
//  SparkedAPI
//
//  Created by Adam Young on 18/03/2025.
//

import Foundation
import ReferenceDataDomain

struct EducationLevelMapper {

    private init() {}

    static func map(from model: EducationLevelModel) throws -> EducationLevel {
        try EducationLevel(
            id: model.requireID(),
            name: model.name,
            nameKey: model.nameKey,
            index: model.index
        )
    }

}
