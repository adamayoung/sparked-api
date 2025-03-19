//
//  InterestGroup.swift
//  AdamDateApp
//
//  Created by Adam Young on 11/03/2025.
//

import Foundation

package struct InterestGroup: Identifiable, Equatable, Hashable, Sendable, Codable {

    package let id: UUID
    package let name: String
    package let nameKey: String

    package init(
        id: UUID,
        name: String,
        nameKey: String
    ) {
        self.id = id
        self.name = name
        self.nameKey = nameKey
    }

}
