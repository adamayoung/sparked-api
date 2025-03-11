//
//  ProfilePhotoModelMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 06/03/2025.
//

import Foundation
import ProfileDomain

struct ProfilePhotoModelMapper {

    private init() {}

    static func map(from profilePhoto: ProfilePhoto) -> ProfilePhotoModel {
        ProfilePhotoModel(
            id: profilePhoto.id,
            userID: profilePhoto.userID,
            profileID: profilePhoto.profileID,
            index: profilePhoto.index,
            filename: profilePhoto.filename
        )
    }

    static func map(from profilePhoto: ProfilePhoto, to model: inout ProfilePhotoModel) {
        model.userID = profilePhoto.userID
        model.profileID = profilePhoto.profileID
        model.index = profilePhoto.index
        model.filename = profilePhoto.filename
    }

}
