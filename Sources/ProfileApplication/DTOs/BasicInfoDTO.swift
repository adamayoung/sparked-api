//
//  BasicInfoDTO.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Foundation

package struct BasicInfoDTO: Identifiable, Equatable, Sendable {

    package let id: UUID
    package let profileID: BasicProfileDTO.ID
    package let gender: GenderDTO
    package let country: CountryDTO
    package let location: String
    package let homeTown: String?
    package let workplace: String?

    package init(
        id: UUID,
        profileID: BasicProfileDTO.ID,
        gender: GenderDTO,
        country: CountryDTO,
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
