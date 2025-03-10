//
//  CreateBasicInfoRequestModel.swift
//  AdamDateApp
//
//  Created by Adam Young on 12/02/2025.
//

import Vapor

struct CreateBasicInfoRequestModel: Content {

    let genderID: UUID
    let countryID: UUID
    let location: String
    let homeTown: String?
    let workplace: String?

}
