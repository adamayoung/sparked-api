//
//  CreateProfileDTO.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import Vapor

struct CreateProfileDTO: Content {

    let displayName: String
    let birthDate: Date

}
