//
//  EducationLevel.swift
//  AdamDateApp
//
//  Created by Adam Young on 18/03/2025.
//

import Foundation

package struct EducationLevel: Identifiable, Equatable, Hashable, Sendable, Codable {

    package let id: UUID
    package let name: String
    package let nameKey: String
    package let index: Int

    package init(
        id: UUID,
        name: String,
        nameKey: String,
        index: Int
    ) {
        self.id = id
        self.name = name
        self.nameKey = nameKey
        self.index = index
    }

}
