//
//  ProfileResponseModelMapper.swift
//  SparkedAPI
//
//  Created by Adam Young on 12/02/2025.
//

import Foundation
import ProfileApplication

struct ProfileResponseModelMapper {

    private init() {}

    static func map(from dto: ProfileDTO) -> ProfileResponseModel {
        let photos = dto.photos.map {
            ProfilePhotoResponseModelMapper.map(from: $0, profileID: dto.id)
        }
        let interests = dto.interests.map(InterestResponseModelMapper.map)

        return ProfileResponseModel(
            id: dto.id,
            displayName: dto.displayName,
            age: dto.age,
            genderID: dto.genderID,
            countryID: dto.countryID,
            location: dto.location,
            homeTown: dto.homeTown,
            workplace: dto.workplace,
            photos: photos,
            interests: interests
        )
    }

}
