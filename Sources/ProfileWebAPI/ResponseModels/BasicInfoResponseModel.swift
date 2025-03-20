//
//  BasicInfoResponseModel.swift
//  AdamDateApp
//
//  Created by Adam Young on 11/02/2025.
//

import Vapor

struct BasicInfoResponseModel: Content, Equatable {

    let id: UUID
    let genderID: UUID
    let countryID: UUID
    let location: String
    let homeTown: String?
    let workplace: String?

}
