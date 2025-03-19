//
//  StarSignDTO.swift
//  AdamDateApp
//
//  Created by Adam Young on 18/03/2025.
//

import Foundation

package struct StarSignDTO: Identifiable, Equatable, Sendable {

    package let id: UUID
    package let name: String
    package let nameKey: String
    package let glyph: String

    package init(
        id: UUID,
        name: String,
        nameKey: String,
        glyph: String
    ) {
        self.id = id
        self.name = name
        self.nameKey = nameKey
        self.glyph = glyph
    }

}
