//
//  ProfileDTO.swift
//  AdamDateAPI
//
//  Created by Adam Young on 09/01/2025.
//

import Vapor

struct ProfileDTO: Content, Identifiable {

    let id: UUID
    let displayName: String

}
