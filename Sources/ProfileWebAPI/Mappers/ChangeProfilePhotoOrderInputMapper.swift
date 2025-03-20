//
//  ChangeProfilePhotoOrderInputMapper.swift
//  SparkedAPI
//
//  Created by Adam Young on 11/03/2025.
//

import Foundation
import ProfileApplication

struct ChangeProfilePhotoOrderInputMapper {

    private init() {}

    static func map(
        profileID: UUID,
        photoID: UUID,
        newIndex: Int
    ) -> ChangeProfilePhotoOrderInput {
        ChangeProfilePhotoOrderInput(
            profileID: profileID,
            photoID: photoID,
            newIndex: newIndex
        )
    }

}
