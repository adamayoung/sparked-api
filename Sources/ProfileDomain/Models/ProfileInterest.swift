//
//  ProfileInterest.swift
//  AdamDateApp
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation

package struct ProfileInterest: Identifiable, Equatable, Hashable, Sendable, Codable {

    package let id: UUID
    package let userID: User.ID
    package let profileID: BasicProfile.ID
    package let interestID: Interest.ID

    package init(
        id: UUID = UUID(),
        userID: User.ID,
        profileID: BasicProfile.ID,
        interestID: Interest.ID
    ) {
        self.id = id
        self.userID = userID
        self.profileID = profileID
        self.interestID = interestID
    }

}
