//
//  ProfileDTO.swift
//  SparkedAPI
//
//  Created by Adam Young on 12/02/2025.
//

import Foundation

package struct ProfileDTO: Identifiable, Equatable, Sendable {

    package let id: UUID
    package let displayName: String
    package let birthDate: Date
    package let age: Int
    package let genderID: UUID
    package let countryID: UUID
    package let location: String
    package let homeTown: String?
    package let workplace: String?
    package let photos: [ProfilePhotoDTO]
    package let interestIDs: [UUID]
    package let height: Double?
    package let educationLevelID: UUID?
    package let starSignID: UUID?

    package init(
        id: UUID,
        displayName: String,
        birthDate: Date,
        age: Int,
        genderID: UUID,
        countryID: UUID,
        location: String,
        homeTown: String? = nil,
        workplace: String? = nil,
        photos: [ProfilePhotoDTO],
        interestIDs: [UUID],
        height: Double?,
        educationLevelID: UUID?,
        starSignID: UUID?
    ) {
        self.id = id
        self.displayName = displayName
        self.birthDate = birthDate
        self.age = age
        self.genderID = genderID
        self.countryID = countryID
        self.location = location
        self.homeTown = homeTown
        self.workplace = workplace
        self.photos = photos
        self.interestIDs = interestIDs
        self.height = height
        self.educationLevelID = educationLevelID
        self.starSignID = starSignID
    }

}
