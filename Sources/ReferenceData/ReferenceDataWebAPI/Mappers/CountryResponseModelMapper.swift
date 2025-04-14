//
//  CountryResponseModelMapper.swift
//  SparkedAPI
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation
import ReferenceDataApplication

struct CountryResponseModelMapper {

    private init() {}

    static func map(from dto: CountryDTO) -> CountryResponseModel {
        CountryResponseModel(
            id: dto.id,
            code: dto.code,
            name: dto.name,
            nameKey: dto.nameKey
        )
    }

}
