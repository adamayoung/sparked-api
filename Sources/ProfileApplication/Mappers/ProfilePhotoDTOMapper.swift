//
//  ProfilePhotoDTOMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 20/02/2025.
//

import Foundation
import ProfileDomain

struct ProfilePhotoDTOMapper {

    private init() {}

    static func map(from profilePhoto: ProfilePhoto, photoURL: URL) -> ProfilePhotoDTO {
        ProfilePhotoDTO(
            id: profilePhoto.id,
            index: profilePhoto.index,
            url: photoURL
        )
    }

}
