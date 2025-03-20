//
//  BasicProfile.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import Foundation

package struct BasicProfile: Identifiable, Equatable, Hashable, Sendable, Codable {

    package let id: UUID
    package let displayName: String
    package let birthDate: Date
    package let bio: String
    package let ownerID: User.ID

    package var age: Int {
        let now = Date()
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthDate, to: now)
        let age = ageComponents.year

        return age ?? 0
    }

    package init(
        id: UUID = UUID(),
        displayName: String,
        birthDate: Date,
        bio: String,
        ownerID: User.ID
    ) {
        self.id = id
        self.displayName = displayName
        self.birthDate = birthDate
        self.bio = bio
        self.ownerID = ownerID
    }

}
