//
//  CountryDTOMapper.swift
//  SparkedAPI
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation
import ReferenceDataDomain

struct CountryDTOMapper {

    private init() {}

    static func map(from country: Country) -> CountryDTO {
        CountryDTO(
            id: country.id,
            code: country.code,
            name: country.name,
            nameKey: country.nameKey
        )
    }

}
