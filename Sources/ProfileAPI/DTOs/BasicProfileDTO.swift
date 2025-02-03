//
//  BasicProfileDTO.swift
//  AdamDateAPI
//
//  Created by Adam Young on 09/01/2025.
//

import Vapor

struct BasicProfileDTO: Content, Equatable {

    let id: UUID
    let displayName: String

}
