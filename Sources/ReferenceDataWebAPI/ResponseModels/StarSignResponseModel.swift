//
//  StarSignResponseModel.swift
//  AdamDateApp
//
//  Created by Adam Young on 18/03/2025.
//

import Vapor

struct StarSignResponseModel: Equatable, Content {

    let id: UUID
    let name: String
    let nameKey: String
    let glyph: String

}
