//
//  ReferenceDataSchemas.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import Foundation
@preconcurrency import GraphQLKit
import Vapor

package struct ReferenceDataSchema<Resolver: ReferenceDataResolver> {

    private init() {}

    package static var all: [PartialSchema<Resolver, Request>] {
        [
            CountrySchema(),
            GenderSchema()
        ]
    }

}
