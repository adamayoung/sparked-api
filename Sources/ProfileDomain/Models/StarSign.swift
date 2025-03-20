//
//  StarSign.swift
//  SparkedAPI
//
//  Created by Adam Young on 18/03/2025.
//

import Foundation

package struct StarSign: Identifiable, Equatable, Hashable, Sendable, Codable {

    package let id: UUID
    package let name: String
    package let glyph: String

    package init(
        id: UUID,
        name: String,
        glyph: String
    ) {
        self.id = id
        self.name = name
        self.glyph = glyph
    }

}
