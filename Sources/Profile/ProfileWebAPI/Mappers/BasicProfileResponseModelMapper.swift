//
//  BasicProfileResponseModelMapper.swift
//  SparkedAPI
//
//  Created by Adam Young on 30/01/2025.
//

import Foundation
import ProfileApplication

struct BasicProfileResponseModelMapper {

    private init() {}

    static func map(from dto: BasicProfileDTO) -> BasicProfileResponseModel {
        BasicProfileResponseModel(
            id: dto.id,
            displayName: dto.displayName,
            age: dto.age,
            bio: dto.bio
        )
    }

}
