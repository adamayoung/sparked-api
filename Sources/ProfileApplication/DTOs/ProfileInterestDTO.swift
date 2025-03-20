//
//  ProfileInterestDTO.swift
//  AdamDateApp
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation

package struct ProfileInterestDTO: Identifiable, Equatable, Sendable {

    package let id: UUID
    package let interestID: UUID
    package let name: String
    package let glyph: String

    package init(
        id: UUID,
        interestID: UUID,
        name: String,
        glyph: String
    ) {
        self.id = id
        self.interestID = interestID
        self.name = name
        self.glyph = glyph
    }

}
