//
//  InterestGroupResponseModel.swift
//  AdamDateApp
//
//  Created by Adam Young on 13/03/2025.
//

import Vapor

struct InterestGroupResponseModel: Equatable, Content {

    let id: UUID
    let name: String
    let interests: [InterestResponseModel]?

    init(
        id: UUID,
        name: String,
        interests: [InterestResponseModel]? = nil
    ) {
        self.id = id
        self.name = name
        self.interests = interests
    }

}
