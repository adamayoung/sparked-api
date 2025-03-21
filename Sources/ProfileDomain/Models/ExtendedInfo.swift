//
//  ExtendedInfo.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation

package struct ExtendedInfo: Identifiable, Equatable, Hashable, Sendable, Codable {

    package let id: UUID
    package let profileID: BasicProfile.ID
    package let height: Double?
    package let educationLevelID: EducationLevel.ID?
    package let starSignID: StarSign.ID?
    package let ownerID: User.ID

    package init(
        id: UUID = UUID(),
        profileID: BasicProfile.ID,
        height: Double? = nil,
        educationLevelID: EducationLevel.ID? = nil,
        starSignID: StarSign.ID? = nil,
        ownerID: User.ID
    ) {
        self.id = id
        self.profileID = profileID
        self.height = height
        self.educationLevelID = educationLevelID
        self.starSignID = starSignID
        self.ownerID = ownerID
    }

}
