//
//  BasicInfo.swift
//  AdamDateApp
//
//  Created by Adam Young on 04/02/2025.
//

import Foundation

package struct BasicInfo: Identifiable, Equatable, Sendable {

    package let id: UUID
    package let profileID: BasicProfile.ID
    package let gender: Gender
    package let country: Country
    package let location: String
    package let homeTown: String?
    package let workplace: String?

    package init(
        id: UUID,
        profileID: BasicProfile.ID,
        gender: Gender,
        country: Country,
        location: String,
        homeTown: String? = nil,
        workplace: String? = nil
    ) {
        self.id = id
        self.profileID = profileID
        self.gender = gender
        self.country = country
        self.location = location
        self.homeTown = homeTown
        self.workplace = workplace
    }

}
