//
//  MeControllerTests.swift
//  SparkedAPI
//
//  Created by Adam Young on 05/02/2025.
//

import APITestingSupport
import AuthKit
import Foundation
import IdentityApplication
import Testing
import VaporTesting

@testable import IdentityWebAPI

@Suite("MeController", .serialized)
struct MeControllerTests {

    let controller: MeController
    let fetchUserUseCase: FetchUserStubUseCase

    init() throws {
        self.fetchUserUseCase = FetchUserStubUseCase()
        self.controller = MeController()
    }

    @Test("me when valid JWT token with matching user returns user")
    func meWhenValidJWTTokenWithMatchingUserReturnsUser() async throws {
        let userID = try #require(UUID(uuidString: "B8130004-7694-46E0-8D36-AB46FDCCB7AB"))
        let userDTO = try UserDTO(
            id: userID,
            firstName: "Dave",
            familyName: "Smith",
            fullName: "Dave Smith",
            email: "email@example.com",
            roles: [
                RoleDTO(
                    id: #require(UUID(uuidString: "76A066CA-ED8F-46B9-B2D2-1901019755A9")),
                    code: "USER",
                    name: "User",
                    description: "User role"
                )
            ],
            isVerified: true,
            isActive: true
        )
        let tokenPayload = TokenPayload(
            subject: userID.uuidString,
            email: "email@example.com",
            fullName: "Dave Smith",
            roles: ["USER"],
            configuration: JWTConfiguration(
                issuer: "test",
                audience: "test",
                expiration: 1000
            ),
            dateProvider: { Date.now }
        )
        fetchUserUseCase.executeResult = .success(userDTO)

        try await testWithApp(controller, jwtPayload: tokenPayload) { app, jwt in
            app.identityUseCases.use { _ in fetchUserUseCase }

            try await app.testing().test(
                .GET, "me",
                beforeRequest: { req in
                    if let jwt {
                        req.headers.bearerAuthorization = .init(token: jwt)
                    }
                },
                afterResponse: { res async in
                    #expect(res.status == .ok)
                }
            )
        }
    }

    @Test("me when no authorization header throws unauthorized error")
    func meWhenNoAuthorizationHeaderThrowsUnauthorizedError() async throws {
        try await testWithApp(controller) { app in
            try await app.testing().test(
                .GET, "me",
                afterResponse: { res async in
                    #expect(res.status == .unauthorized)
                }
            )
        }
    }

    @Test("me when jwt subject is not a UUID throws forbidden error")
    func meWhenJWTSubjectIsNotAUUIDThrowsForbiddenError() async throws {
        let tokenPayload = TokenPayload(
            subject: "invalid-uuid",
            email: "email@example.com",
            fullName: "Dave Smith",
            roles: ["USER"],
            configuration: JWTConfiguration(
                issuer: "test",
                audience: "test",
                expiration: 1000
            ),
            dateProvider: { Date.now }
        )

        try await testWithApp(controller, jwtPayload: tokenPayload) { app, jwt in
            try await app.testing().test(
                .GET, "me",
                beforeRequest: { req in
                    if let jwt {
                        req.headers.bearerAuthorization = .init(token: jwt)
                    }
                },
                afterResponse: { res async in
                    #expect(res.status == .forbidden)
                }
            )
        }
    }

}
