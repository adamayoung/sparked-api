//
//  UserDTO.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import Vapor

struct UserDTO: Content, Identifiable {

    let id: UUID
    let firstName: String
    let lastName: String
    let email: String
    let isVerified: Bool

}
