//
//  UserResponseModel.swift
//  SparkedAPI
//
//  Created by Adam Young on 09/01/2025.
//

import Vapor

struct UserResponseModel: Content, Identifiable {

    let id: UUID
    let firstName: String
    let familyName: String
    let email: String
    let roles: [String]
    let isVerified: Bool

}
