//
//  AuthControllerTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 29/01/2025.
//

import AdamDateAuth
import Foundation
import JWT
import Testing
import VaporTesting

@testable import IdentityAPI
@testable import IdentityEntities

@Suite("AuthController", .serialized)
struct AuthControllerTests {

    let registerUserUseCase: RegisterUserStubUseCase
    let authenticateUserUseCase: AuthenticateUserStubUseCase
    let fetchUserUseCase: FetchUserStubUseCase
    let tokenPayloadProvider: TokenPayloadStubProvider

    init() throws {
        self.registerUserUseCase = RegisterUserStubUseCase()
        self.authenticateUserUseCase = AuthenticateUserStubUseCase()
        self.fetchUserUseCase = FetchUserStubUseCase()
        self.tokenPayloadProvider = TokenPayloadStubProvider()
    }

    @Test("register when request body is valid returns registered user")
    func registerWhenRequestBodyIsValidReturnsRegisteredUser() async throws {
        let registerUserDTO = RegisterUserDTO(
            firstName: "Dave",
            lastName: "Smith",
            email: "email@example.com",
            password: "pass123"
        )
        let user = try User(
            id: #require(UUID(uuidString: "ABB41E11-03AB-4998-A349-9DE3FA859802")),
            firstName: "Dave",
            lastName: "Smith",
            email: "email@example.com",
            isVerified: true,
            isActive: true
        )

        registerUserUseCase.executeResult = .success(user)

        try await withApp { app in
            try await app.testing().test(
                .POST, "auth/register",
                beforeRequest: { req in
                    try req.content.encode(registerUserDTO)
                },
                afterResponse: { res async in
                    #expect(res.status == .created)
                }
            )
        }
    }

    @Test("register when request body is invalid throws bad request error")
    func registerWhenRequestBodyIsInvalidReturnsBadRequest() async throws {
        registerUserUseCase.executeResult = .failure(.unknown())

        try await withApp { app in
            try await app.testing().test(
                .POST, "auth/register",
                beforeRequest: { req in
                    try req.content.encode("invalid-data")
                },
                afterResponse: { res async in
                    #expect(res.status == .badRequest)
                }
            )
        }
    }

    @Test("token when correct email and password returns token")
    func tokenWhenCorrectEmailAndPasswordReturnsToken() async throws {
        let userCredentialDTO = UserCredentialDTO(
            email: "email@example.com",
            password: "pass123"
        )
        let user = try User(
            id: #require(UUID(uuidString: "ABB41E11-03AB-4998-A349-9DE3FA859802")),
            firstName: "Dave",
            lastName: "Smith",
            email: "email@example.com",
            isVerified: true,
            isActive: true
        )
        let tokenPayload = TokenPayload(
            subject: user.id.uuidString,
            email: "email@example.com",
            fullName: "Dave Smith",
            configuration: JWTConfiguration(
                issuer: "test",
                audience: "test",
                expiration: 1000
            ),
            dateProvider: { Date(timeIntervalSince1970: 0) }
        )
        authenticateUserUseCase.executeResult = .success(user)
        tokenPayloadProvider.tokenPayloadResult = tokenPayload

        try await withApp { app in
            try await app.testing().test(
                .POST, "auth/token",
                beforeRequest: { req in
                    try req.content.encode(userCredentialDTO)
                },
                afterResponse: { res async in
                    let tokenDTO = try? res.content.decode(TokenDTO.self)
                    let tokenData = tokenDTO?.token.data(using: .utf8) ?? Data()
                    let jwt = try? DefaultJWTParser().parse(tokenData, as: TokenPayload.self)

                    #expect(jwt?.payload == tokenPayload)
                }
            )
        }
    }

    @Test("token when request body is invalid throws bad request error")
    func tokenWhenRequestBodyIsInvalidReturnsBadRequest() async throws {
        authenticateUserUseCase.executeResult = .failure(.unknown())

        try await withApp { app in
            try await app.testing().test(
                .POST, "auth/token",
                beforeRequest: { req in
                    try req.content.encode("invalid-data")
                },
                afterResponse: { res async in
                    #expect(res.status == .badRequest)
                }
            )
        }
    }

    @Test("token when incorrect email or password throws unauthorized error")
    func tokenWhenIncorrectEmailAndPasswordThrowsUnauthorizedError() async throws {
        let userCredentialDTO = UserCredentialDTO(
            email: "email@example.com",
            password: "pass123"
        )
        authenticateUserUseCase.executeResult = .failure(.invalidEmailOrPassword)

        try await withApp { app in
            try await app.testing().test(
                .POST, "auth/token",
                beforeRequest: { req in
                    try req.content.encode(userCredentialDTO)
                },
                afterResponse: { res async in
                    #expect(res.status == .unauthorized)
                }
            )
        }
    }

    @Test("me when valid JWT token with matching user returns user")
    func meWhenValidJWTTokenWithMatchingUserReturnsUser() async throws {
        let userID = try #require(UUID(uuidString: "B8130004-7694-46E0-8D36-AB46FDCCB7AB"))
        let user = User(
            id: userID,
            firstName: "Dave",
            lastName: "Smith",
            email: "email@example.com",
            isVerified: true,
            isActive: true
        )
        let tokenPayload = TokenPayload(
            subject: userID.uuidString,
            email: "email@example.com",
            fullName: "Dave Smith",
            configuration: JWTConfiguration(
                issuer: "test",
                audience: "test",
                expiration: 1000
            ),
            dateProvider: { Date.now }
        )
        fetchUserUseCase.executeResult = .success(user)

        try await withApp { app in
            let jwt = (try? await app.jwt.keys.sign(tokenPayload)) ?? ""
            try await app.testing().test(
                .GET, "auth/me",
                beforeRequest: { req in
                    req.headers.bearerAuthorization = .init(token: jwt)
                },
                afterResponse: { res async in
                    #expect(res.status == .ok)
                }
            )
        }
    }

    @Test("me when no authorization header throws unauthorized error")
    func meWhenNoAuthorizationHeaderThrowsUnauthorizedError() async throws {
        try await withApp { app in
            try await app.testing().test(
                .GET, "auth/me",
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
            configuration: JWTConfiguration(
                issuer: "test",
                audience: "test",
                expiration: 1000
            ),
            dateProvider: { Date.now }
        )

        try await withApp { app in
            let jwt = (try? await app.jwt.keys.sign(tokenPayload)) ?? ""
            try await app.testing().test(
                .GET, "auth/me",
                beforeRequest: { req in
                    req.headers.bearerAuthorization = .init(token: jwt)
                },
                afterResponse: { res async in
                    #expect(res.status == .forbidden)
                }
            )
        }
    }

}

extension AuthControllerTests {

    private func withApp(_ test: (Application) async throws -> Void) async throws {
        let app = try await Application.make(.testing)

        do {
            try await configure(app)
            try await test(app)
        } catch {
            try await app.asyncShutdown()
            throw error
        }

        try await app.asyncShutdown()
    }

    private func configure(_ app: Application) async throws {
        let hmac = HMACKey(from: "secret123")
        await app.jwt.keys.add(hmac: hmac, digestAlgorithm: .sha256)

        try app.register(
            collection: AuthController(
                registerUserUseCase: { registerUserUseCase },
                authenticateUserUseCase: { authenticateUserUseCase },
                fetchUserUseCase: { fetchUserUseCase },
                tokenPayloadProvider: { tokenPayloadProvider }
            )
        )
    }

}
