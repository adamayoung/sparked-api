//
//  StarSign.swift
//  AdamDateApp
//
//  Created by Adam Young on 18/03/2025.
//

import Foundation

package struct StarSign: Identifiable, Equatable, Hashable, Sendable, Codable {

    package let id: UUID
    package let name: String
    package let nameKey: String
    package let glyph: String
    package let index: Int

    package init(
        id: UUID,
        name: String,
        nameKey: String,
        glyph: String,
        index: Int
    ) {
        self.id = id
        self.name = name
        self.nameKey = nameKey
        self.glyph = glyph
        self.index = index
    }

}
