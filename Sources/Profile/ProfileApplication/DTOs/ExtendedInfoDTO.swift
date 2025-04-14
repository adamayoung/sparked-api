//
//  ExtendedInfoDTO.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation

package struct ExtendedInfoDTO: Identifiable, Equatable, Sendable {

    package let id: UUID
    package let profileID: UUID
    package let height: Double?
    package let educationLevelID: UUID?
    package let starSignID: UUID?

    package init(
        id: UUID,
        profileID: UUID,
        height: Double? = nil,
        educationLevelID: UUID? = nil,
        starSignID: UUID? = nil
    ) {
        self.id = id
        self.profileID = profileID
        self.height = height
        self.educationLevelID = educationLevelID
        self.starSignID = starSignID
    }

}
