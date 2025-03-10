//
//  graphQLRoutes.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import GraphQLKit
import GraphiQLVapor
import Vapor

func graphQLRoutes(_ routes: RoutesBuilder, environment: Environment) throws {
    let graphQLAPI = try AdamDateGraphQLAPI()

    routes.register(
        graphQLSchema: graphQLAPI.schema,
        withResolver: graphQLAPI.resolver,
        at: ""
    )

    if !environment.isRelease {
        routes.enableGraphiQL(on: "explorer")
    }
}
