//
//  BasicProfileResponseModel.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import Vapor

struct BasicProfileResponseModel: Content, Equatable {

    let id: UUID
    let displayName: String
    let age: Int

}
