//
//  CountryResponseModel.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import Vapor

struct CountryResponseModel: Content {

    let id: UUID
    let code: String
    let name: String

}
