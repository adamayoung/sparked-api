//
//  ProfilePhotoResponseModelMapper.swift
//  SparkedAPI
//
//  Created by Adam Young on 06/03/2025.
//

import Foundation
import ProfileApplication

struct ProfilePhotoResponseModelMapper {

    private init() {}

    static func map(
        from dto: ProfilePhotoDTO,
        profileID: BasicProfileDTO.ID
    ) -> ProfilePhotoResponseModel {
        let url = Self.mapPhotoURL(from: dto, profileID: profileID)

        return ProfilePhotoResponseModel(
            id: dto.id,
            url: url
        )
    }

}

extension ProfilePhotoResponseModelMapper {

    private static func mapPhotoURL(
        from dto: ProfilePhotoDTO,
        profileID: BasicProfileDTO.ID
    ) -> URL {
        if !dto.isLocalFile {
            return dto.url
        }

        guard let url = URL(string: "/api/profiles/\(profileID)/photos/\(dto.id)/image") else {
            fatalError("Invalid URL string")
        }

        return url
    }

}
