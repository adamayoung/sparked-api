//
//  BasicInfo.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation

package struct BasicInfo: Identifiable, Equatable, Hashable, Sendable, Codable {

    package let id: UUID
    package let userID: User.ID
    package let profileID: BasicProfile.ID
    package let genderID: Gender.ID
    package let countryID: Country.ID
    package let location: String
    package let homeTown: String?
    package let workplace: String?

    package init(
        id: UUID = UUID(),
        userID: User.ID,
        profileID: BasicProfile.ID,
        genderID: Gender.ID,
        countryID: Country.ID,
        location: String,
        homeTown: String? = nil,
        workplace: String? = nil
    ) {
        self.id = id
        self.userID = userID
        self.profileID = profileID
        self.genderID = genderID
        self.countryID = countryID
        self.location = location
        self.homeTown = homeTown
        self.workplace = workplace
    }

}
