//
//  AddProfilePhotoInput.swift
//  SparkedAPI
//
//  Created by Adam Young on 19/02/2025.
//

import Foundation

package struct AddProfilePhotoInput: Equatable, Sendable {

    package let profileID: UUID
    package let photoData: Data
    package let photoType: String

    package init(
        profileID: UUID,
        photoData: Data,
        photoType: String
    ) {
        self.profileID = profileID
        self.photoData = photoData
        self.photoType = photoType
    }

}
