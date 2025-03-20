//
//  ProfileInterest.swift
//  AdamDateApp
//
//  Created by Adam Young on 17/03/2025.
//

import Foundation

package struct ProfileInterest: Identifiable, Equatable, Hashable, Sendable, Codable {

    package let id: UUID
    package let profileID: BasicProfile.ID
    package let interestID: Interest.ID
    package let ownerID: User.ID

    package init(
        id: UUID = UUID(),
        profileID: BasicProfile.ID,
        interestID: Interest.ID,
        ownerID: User.ID
    ) {
        self.id = id
        self.profileID = profileID
        self.interestID = interestID
        self.ownerID = ownerID
    }

}
