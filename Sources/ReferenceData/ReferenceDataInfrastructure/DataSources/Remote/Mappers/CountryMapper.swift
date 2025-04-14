//
//  CountryMapper.swift
//  SparkedAPI
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation
import ReferenceDataDomain

struct CountryMapper {

    private init() {}

    static func map(from model: CountryModel) throws -> Country {
        try Country(
            id: model.requireID(),
            code: model.code,
            name: model.name,
            nameKey: model.nameKey
        )
    }

}
