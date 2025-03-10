//
//  ProfileSchema.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import Foundation
@preconcurrency import GraphQLKit
import Vapor

package struct ProfileSchema<Resolver: ProfileResolver> {

    private init() {}

    package static var all: [PartialSchema<Resolver, Request>] {
        [
            BasicProfileSchema()
        ]
    }

}
