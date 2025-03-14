//
//  InterestGroupAggregateDTO.swift
//  AdamDateApp
//
//  Created by Adam Young on 11/03/2025.
//

import Foundation

package struct InterestGroupAggregateDTO: Identifiable, Equatable, Sendable {

    package let id: UUID
    package let name: String
    package let interests: [InterestDTO]

    package init(
        id: UUID,
        name: String,
        interests: [InterestDTO]
    ) {
        self.id = id
        self.name = name
        self.interests = interests
    }

}
