//
//  SharedSchema.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import Foundation
@preconcurrency import GraphQLKit
import Vapor

struct SharedSchema<Resolver: AdamDateResolver> {

    private init() {}

    static var all: [PartialSchema<Resolver, Request>] {
        [
            UUIDSchema(),
            URLSchema()
        ]
    }

}
