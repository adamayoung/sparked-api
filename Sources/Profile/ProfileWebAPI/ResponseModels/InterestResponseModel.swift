//
//  InterestResponseModel.swift
//  SparkedAPI
//
//  Created by Adam Young on 17/03/2025.
//

import Vapor

struct InterestResponseModel: Content, Equatable {

    package let id: UUID
    package let name: String
    package let glyph: String

}
