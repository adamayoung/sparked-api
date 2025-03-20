//
//  ChangeProfilePhotoOrderInput.swift
//  SparkedAPI
//
//  Created by Adam Young on 11/03/2025.
//

import Foundation

package struct ChangeProfilePhotoOrderInput: Equatable, Sendable {

    package let profileID: UUID
    package let photoID: UUID
    package let newIndex: Int

    package init(
        profileID: UUID,
        photoID: UUID,
        newIndex: Int
    ) {
        self.profileID = profileID
        self.photoID = photoID
        self.newIndex = newIndex
    }

}
