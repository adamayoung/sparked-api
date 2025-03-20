//
//  CreateBasicInfoInput.swift
//  AdamDateApp
//
//  Created by Adam Young on 11/02/2025.
//

import Foundation

package struct CreateBasicInfoInput: Equatable, Sendable {

    package let profileID: UUID
    package let genderID: UUID
    package let countryID: UUID
    package let location: String
    package let homeTown: String?
    package let workplace: String?

    package init(
        profileID: UUID,
        genderID: UUID,
        countryID: UUID,
        location: String,
        homeTown: String? = nil,
        workplace: String? = nil
    ) {
        self.profileID = profileID
        self.genderID = genderID
        self.countryID = countryID
        self.location = location
        self.homeTown = homeTown
        self.workplace = workplace
    }

}
