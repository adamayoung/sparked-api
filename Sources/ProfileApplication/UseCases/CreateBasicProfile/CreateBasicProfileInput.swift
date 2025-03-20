//
//  CreateBasicProfileInput.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation

package struct CreateBasicProfileInput: Equatable, Sendable {

    package let displayName: String
    package let birthDate: Date
    package let bio: String
    package let ownerID: UUID

    package init(
        displayName: String,
        birthDate: Date,
        bio: String,
        ownerID: UUID
    ) {
        self.displayName = displayName
        self.birthDate = birthDate
        self.bio = bio
        self.ownerID = ownerID
    }

}
