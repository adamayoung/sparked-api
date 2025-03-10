//
//  AdamDateSchema.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import Foundation
@preconcurrency import GraphQLKit
import ProfileGraphQL
import ReferenceDataGraphQL
import Vapor

struct AdamDateSchema {

    private init() {}

    static func build() throws -> Schema<AdamDateResolver, Request> {
        try SchemaBuilder(AdamDateResolver.self, Request.self)
            .use(partials: ProfileSchema.all)
            .use(partials: ReferenceDataSchema.all)
            .use(partials: SharedSchema.all)
            .build()
    }

}
