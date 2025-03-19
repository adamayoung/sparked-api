//
//  InterestGroupDTO.swift
//  AdamDateApp
//
//  Created by Adam Young on 12/03/2025.
//

import Foundation

package struct InterestGroupDTO: Identifiable, Equatable, Sendable {

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
