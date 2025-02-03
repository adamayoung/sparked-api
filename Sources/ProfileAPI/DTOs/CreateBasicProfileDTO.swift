//
//  CreateBasicProfileDTO.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import Vapor

struct CreateBasicProfileDTO: Content {

    let displayName: String
    let birthDate: Date

}
