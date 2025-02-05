//
//  GenderDTO.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation

package struct GenderDTO: Identifiable, Equatable, Sendable {

    package let id: UUID
    package let name: String

    package init(
        id: UUID,
        name: String
    ) {
        self.id = id
        self.name = name
    }

}
