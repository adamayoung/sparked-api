//
//  UUIDSchema.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import Foundation
import GraphQLKit
import Vapor

final class UUIDSchema<Resolver: AdamDateResolver, Request>: PartialSchema<Resolver, Request> {

    @TypeDefinitions override var types: Types {
        Scalar(UUID.self)
    }

}
