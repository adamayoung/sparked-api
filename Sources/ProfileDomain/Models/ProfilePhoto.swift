//
//  ProfilePhoto.swift
//  AdamDateApp
//
//  Created by Adam Young on 19/02/2025.
//

import Foundation

package struct ProfilePhoto: Identifiable, Equatable, Hashable, Sendable, Codable {

    package let id: UUID
    package let userID: User.ID
    package let profileID: BasicProfile.ID
    package let index: Int
    package let filename: String

    package init(
        id: UUID = UUID(),
        userID: User.ID,
        profileID: BasicProfile.ID,
        index: Int,
        filename: String
    ) {
        self.id = id
        self.userID = userID
        self.profileID = profileID
        self.index = index
        self.filename = filename
    }

    package func withIndex(_ newIndex: Int) -> ProfilePhoto {
        ProfilePhoto(
            id: id,
            userID: userID,
            profileID: profileID,
            index: newIndex,
            filename: filename
        )
    }

}
