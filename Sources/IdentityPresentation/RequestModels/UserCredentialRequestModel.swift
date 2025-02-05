//
//  UserCredentialRequestModel.swift
//  AdamDateApp
//
//  Created by Adam Young on 28/01/2025.
//

import Vapor

struct UserCredentialRequestModel: Content {

    let email: String
    let password: String

}
