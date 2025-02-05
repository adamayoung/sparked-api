//
//  CountryDTOMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation
import ProfileDomain

struct CountryDTOMapper {

    private init() {}

    static func map(from country: Country) -> CountryDTO {
        CountryDTO(
            id: country.id,
            name: country.name
        )
    }

}
