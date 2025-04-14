//
//  CountryDTO.swift
//  SparkedAPI
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation

package struct CountryDTO: Identifiable, Equatable {

    package let id: UUID
    package let code: String
    package let name: String
    package let nameKey: String

    package init(
        id: UUID,
        code: String,
        name: String,
        nameKey: String
    ) {
        self.id = id
        self.code = code
        self.name = name
        self.nameKey = nameKey
    }

}
