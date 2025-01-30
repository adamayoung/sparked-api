//
//  CreateBasicProfileInput.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation
import ProfileEntities

package struct CreateBasicProfileInput: Equatable, Sendable {

    package let userID: UUID
    package let displayName: String
    package let birthDate: Date

    package init(
        userID: UUID,
        displayName: String,
        birthDate: Date
    ) {
        self.userID = userID
        self.displayName = displayName
        self.birthDate = birthDate
    }

}
