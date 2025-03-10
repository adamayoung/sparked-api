//
//  AdamDateGraphQLAPI.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import Foundation
import Graphiti
import ProfileGraphQL
import ReferenceDataGraphQL
import Vapor

struct AdamDateGraphQLAPI: API {

    typealias Resolver = AdamDateResolver

    let resolver: Resolver
    let schema: Schema<Resolver, Request>

    init(
        resolver: Resolver,
        schema: Schema<Resolver, Request>
    ) throws {
        self.resolver = resolver
        self.schema = schema
    }

    init() throws {
        try self.init(
            resolver: AdamDateResolver(
                profileResolver: ProfileGraphQLFactory.makeResolver(),
                referenceDataResolver: ReferenceDataGraphQLFactory.makeResolver()
            ),
            schema: AdamDateSchema.build()
        )
    }

}
