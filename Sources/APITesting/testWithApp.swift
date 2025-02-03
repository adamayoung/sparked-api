//
//  withApp.swift
//  AdamDateApp
//
//  Created by Adam Young on 30/01/2025.
//

import AdamDateAuth
import Foundation
import JWT
import VaporTesting

package func testWithApp(
    _ routeCollection: RouteCollection,
    test: (Application) async throws -> Void
) async throws {
    try await testWithApp([routeCollection], test: test)
}

package func testWithApp(
    _ routeCollections: [RouteCollection],
    test: (Application) async throws -> Void
) async throws {
    try await testWithApp(routeCollections, jwtPayload: nil as TokenPayload?) { app, _ in
        try await test(app)
    }
}

package func testWithApp(
    _ routeCollection: RouteCollection,
    jwtPayload: (some JWTPayload)?,
    test: (Application, String?) async throws -> Void
) async throws {
    try await testWithApp(
        [routeCollection],
        jwtPayload: jwtPayload,
        test: test
    )
}

package func testWithApp(
    _ routeCollections: [RouteCollection],
    jwtPayload: (some JWTPayload)?,
    test: (Application, String?) async throws -> Void
) async throws {
    let app = try await Application.make(.testing)
    let hmac = HMACKey(from: "secret123")
    await app.jwt.keys.add(hmac: hmac, digestAlgorithm: .sha256)

    do {
        for routeCollection in routeCollections {
            try app.register(collection: routeCollection)
        }

        let jwt: String? = try await {
            guard let jwtPayload else {
                return nil
            }

            return try await app.jwt.keys.sign(jwtPayload)
        }()

        try await test(app, jwt)
    } catch {
        try await app.asyncShutdown()
        throw error
    }

    try await app.asyncShutdown()
}
