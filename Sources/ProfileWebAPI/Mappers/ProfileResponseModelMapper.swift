//
//  ProfileResponseModelMapper.swift
//  AdamDateApp
//
//  Created by Adam Young on 12/02/2025.
//

import Foundation
import ProfileApplication

struct ProfileResponseModelMapper {

    private init() {}

    static func map(from dto: ProfileDTO) -> ProfileResponseModel {
        ProfileResponseModel(
            id: dto.id,
            displayName: dto.displayName,
            age: dto.age,
            genderID: dto.genderID,
            countryID: dto.countryID,
            location: dto.location,
            homeTown: dto.homeTown,
            workplace: dto.workplace
        )
    }

}
