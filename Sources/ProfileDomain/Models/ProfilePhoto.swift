//
//  ProfilePhoto.swift
//  AdamDateApp
//
//  Created by Adam Young on 19/02/2025.
//

import Foundation

package struct ProfilePhoto: Identifiable, Equatable, Hashable, Sendable, Codable {

    package let id: UUID
    package let profileID: BasicProfile.ID
    package let index: Int
    package let filename: String
    package let ownerID: User.ID

    package init(
        id: UUID = UUID(),
        profileID: BasicProfile.ID,
        index: Int,
        filename: String,
        ownerID: User.ID
    ) {
        self.id = id
        self.profileID = profileID
        self.index = index
        self.filename = filename
        self.ownerID = ownerID
    }

    package func withIndex(_ newIndex: Int) -> ProfilePhoto {
        ProfilePhoto(
            id: id,
            profileID: profileID,
            index: newIndex,
            filename: filename,
            ownerID: ownerID
        )
    }

}
