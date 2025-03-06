//
//  ProfilePhoto.swift
//  AdamDateApp
//
//  Created by Adam Young on 19/02/2025.
//

import Foundation

package struct ProfilePhoto: Identifiable, Equatable, Hashable, Sendable, Codable {

    package let id: UUID
    package let userID: UUID
    package let profileID: UUID
    package let index: Int
    package let filename: String

    package init(
        id: UUID = UUID(),
        userID: UUID,
        profileID: UUID,
        index: Int,
        filename: String
    ) {
        self.id = id
        self.userID = userID
        self.profileID = profileID
        self.index = index
        self.filename = filename
    }

}
