//
//  Profile.swift
//  AdamDateApp
//
//  Created by Adam Young on 12/02/2025.
//

import Foundation

package struct Profile: Identifiable, Equatable, Hashable, Sendable, Codable {

    package let id: UUID
    package let userID: UUID
    package let displayName: String
    package let birthDate: Date
    package let genderID: UUID
    package let countryID: UUID
    package let location: String
    package let homeTown: String?
    package let workplace: String?

    package var age: Int {
        let now = Date()
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthDate, to: now)
        let age = ageComponents.year

        return age ?? 0
    }

    package init(
        id: UUID,
        userID: UUID,
        displayName: String,
        birthDate: Date,
        genderID: UUID,
        countryID: UUID,
        location: String,
        homeTown: String? = nil,
        workplace: String? = nil
    ) {
        self.id = id
        self.userID = userID
        self.displayName = displayName
        self.birthDate = birthDate
        self.genderID = genderID
        self.countryID = countryID
        self.location = location
        self.homeTown = homeTown
        self.workplace = workplace
    }

}
