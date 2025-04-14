//
//  RegisterUserRequestModel.swift
//  SparkedAPI
//
//  Created by Adam Young on 09/01/2025.
//

import Vapor

struct RegisterUserRequestModel: Content {

    let firstName: String
    let familyName: String
    let email: String
    let password: String

}
