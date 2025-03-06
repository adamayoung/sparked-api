//
//  ProfilePhotoMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 06/03/2025.
//

import Foundation
import ProfileDomain

struct ProfilePhotoMapper {

    private init() {}

    static func map(from model: ProfilePhotoModel) throws -> ProfilePhoto {
        try ProfilePhoto(
            id: model.requireID(),
            userID: model.userID,
            profileID: model.profileID,
            index: model.index,
            filename: model.filename
        )
    }

}
