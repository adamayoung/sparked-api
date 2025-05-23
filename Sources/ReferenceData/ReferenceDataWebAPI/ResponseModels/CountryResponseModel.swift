//
//  CountryResponseModel.swift
//  SparkedAPI
//
//  Created by Adam Young on 05/02/2025.
//

import Vapor

struct CountryResponseModel: Equatable, Content {

    let id: UUID
    let code: String
    let name: String
    let nameKey: String

}
