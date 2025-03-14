//
//  InterestResponseModel.swift
//  AdamDateApp
//
//  Created by Adam Young on 13/03/2025.
//

import Vapor

struct InterestResponseModel: Equatable, Content {

    let id: UUID
    let name: String
    let glyph: String
}
