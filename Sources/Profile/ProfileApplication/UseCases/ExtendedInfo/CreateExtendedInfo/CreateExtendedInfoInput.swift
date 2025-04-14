//
//  CreateExtendedInfoInput.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import Foundation

package struct CreateExtendedInfoInput: Equatable, Sendable {

    package let profileID: UUID
    package let height: Double?
    package let educationLevelID: UUID?
    package let starSignID: UUID?

    package init(
        profileID: UUID,
        height: Double? = nil,
        educationLevelID: UUID? = nil,
        starSignID: UUID? = nil
    ) {
        self.profileID = profileID
        self.height = height
        self.educationLevelID = educationLevelID
        self.starSignID = starSignID
    }

}
