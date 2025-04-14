//
//  BasicInfo.swift
//  SparkedAPI
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation

package struct BasicInfo: Identifiable, Equatable, Hashable, Sendable, Codable {

    package let id: UUID
    package let profileID: BasicProfile.ID
    package let genderID: Gender.ID
    package let countryID: Country.ID
    package let location: String
    package let homeTown: String?
    package let workplace: String?
    package let ownerID: User.ID

    package init(
        id: UUID = UUID(),
        profileID: BasicProfile.ID,
        genderID: Gender.ID,
        countryID: Country.ID,
        location: String,
        homeTown: String? = nil,
        workplace: String? = nil,
        ownerID: User.ID
    ) {
        self.id = id
        self.profileID = profileID
        self.genderID = genderID
        self.countryID = countryID
        self.location = location
        self.homeTown = homeTown
        self.workplace = workplace
        self.ownerID = ownerID
    }

}
