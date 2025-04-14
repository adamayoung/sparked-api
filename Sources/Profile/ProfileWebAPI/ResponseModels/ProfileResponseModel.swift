//
//  ProfileResponseModel.swift
//  SparkedAPI
//
//  Created by Adam Young on 12/02/2025.
//

import Vapor

struct ProfileResponseModel: Content, Equatable {

    let id: UUID
    let displayName: String
    let age: Int
    let genderID: UUID
    let countryID: UUID
    let location: String
    let homeTown: String?
    let workplace: String?
    let photos: [ProfilePhotoResponseModel]
    let interestIDs: [UUID]
    let height: Double?
    let educationLevelID: UUID?
    let starSignID: UUID?

}
