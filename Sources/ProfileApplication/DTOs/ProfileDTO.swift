//
//  ProfileDTO.swift
//  AdamDateApp
//
//  Created by Adam Young on 12/02/2025.
//

import Foundation

package struct ProfileDTO: Identifiable, Equatable, Sendable {

    package let id: UUID
    package let userID: UUID
    package let displayName: String
    package let birthDate: Date
    package let age: Int
    package let genderID: UUID
    package let countryID: UUID
    package let location: String
    package let homeTown: String?
    package let workplace: String?

    package init(
        id: UUID,
        userID: UUID,
        displayName: String,
        birthDate: Date,
        age: Int,
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
        self.age = age
        self.genderID = genderID
        self.countryID = countryID
        self.location = location
        self.homeTown = homeTown
        self.workplace = workplace
    }

}
