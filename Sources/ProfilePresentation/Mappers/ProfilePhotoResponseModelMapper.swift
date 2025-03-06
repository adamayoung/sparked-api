//
//  ProfilePhotoResponseModelMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 06/03/2025.
//

import Foundation
import ProfileApplication

struct ProfilePhotoResponseModelMapper {

    private init() {}

    static func map(from dto: ProfilePhotoDTO) -> ProfilePhotoResponseModel {
        let url = Self.mapPhotoURL(from: dto)

        return ProfilePhotoResponseModel(
            id: dto.id,
            index: dto.index,
            url: url
        )
    }

}

extension ProfilePhotoResponseModelMapper {

    private static func mapPhotoURL(from dto: ProfilePhotoDTO) -> URL {
        if dto.isLocalFile {
            return URL(string: "/api/profiles/\(dto.profileID)/photos/\(dto.id)/image")!
        }

        return dto.url
    }

}
