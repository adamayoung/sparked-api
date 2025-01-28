//
//  RegisterUserDTO.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import Vapor

struct RegisterUserDTO: Content {

    let firstName: String
    let lastName: String
    let email: String
    let password: String

}
