//
//  BasicInfo.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation

package struct BasicInfo: Identifiable, Equatable, Hashable, Sendable, Codable {

    package let id: UUID
    package let userID: UUID
    package let profileID: BasicProfile.ID
    package let genderID: UUID
    package let countryID: UUID
    package let location: String
    package let homeTown: String?
    package let workplace: String?

    package init(
        id: UUID = UUID(),
        userID: UUID,
        profileID: BasicProfile.ID,
        genderID: UUID,
        countryID: UUID,
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
