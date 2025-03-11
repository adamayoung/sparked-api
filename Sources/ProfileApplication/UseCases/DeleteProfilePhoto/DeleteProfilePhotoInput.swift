//
//  DeleteProfilePhotoInput.swift
//  AdamDateApp
//
//  Created by Adam Young on 11/03/2025.
//

import Foundation

package struct DeleteProfilePhotoInput: Equatable, Sendable {

    package let profileID: UUID
    package let photoID: UUID

    package init(
        profileID: UUID,
        photoID: UUID
    ) {
        self.profileID = profileID
        self.photoID = photoID
    }

}
