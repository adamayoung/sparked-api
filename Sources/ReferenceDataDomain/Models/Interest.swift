//
//  Interest.swift
//  AdamDateApp
//
//  Created by Adam Young on 11/03/2025.
//

import Foundation

package struct Interest: Identifiable, Equatable, Hashable, Sendable, Codable {

    package let id: UUID
    package let interestGroupID: UUID
    package let name: String
    package let nameKey: String
    package let glyph: String

    package init(
        id: UUID,
        interestGroupID: UUID,
        name: String,
        nameKey: String,
        glyph: String
    ) {
        self.id = id
        self.interestGroupID = interestGroupID
        self.name = name
        self.nameKey = nameKey
        self.glyph = glyph
    }

}
