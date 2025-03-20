//
//  ProfilePhotoModelMapper.swift
//  SparkedAPI
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
            profileID: profilePhoto.profileID,
            index: profilePhoto.index,
            filename: profilePhoto.filename,
            ownerID: profilePhoto.ownerID
        )
    }

    static func map(from profilePhoto: ProfilePhoto, to model: inout ProfilePhotoModel) {
        model.profileID = profilePhoto.profileID
        model.index = profilePhoto.index
        model.filename = profilePhoto.filename
        model.ownerID = profilePhoto.ownerID
    }

}
