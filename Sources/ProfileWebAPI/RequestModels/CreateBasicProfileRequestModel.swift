//
//  CreateBasicProfileRequestModel.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import Vapor

struct CreateBasicProfileRequestModel: Content {

    let displayName: String
    let birthDate: Date
    let bio: String

}
