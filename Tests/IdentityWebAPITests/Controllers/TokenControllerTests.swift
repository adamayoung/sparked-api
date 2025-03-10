//
//  TokenControllerTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import APITesting
import AuthKit
import Foundation
import IdentityApplication
import JWT
import Testing
import VaporTesting

@testable import IdentityWebAPI

@Suite("TokenController", .serialized)
struct TokenControllerTests {

    let controller: TokenController
    let authenticateUserUseCase: AuthenticateUserStubUseCase
    let tokenPayloadService: TokenPayloadStubService

    init() throws {
        self.authenticateUserUseCase = AuthenticateUserStubUseCase()
        self.tokenPayloadService = TokenPayloadStubService()
        self.controller = TokenController()
    }

    @Test("token when correct email and password returns token")
    func tokenWhenCorrectEmailAndPasswordReturnsToken() async throws {
        let userCredentialRequestModel = UserCredentialRequestModel(
            email: "email@example.com",
            password: "pass123"
        )
        let userDTO = try UserDTO(
            id: #require(UUID(uuidString: "ABB41E11-03AB-4998-A349-9DE3FA859802")),
            firstName: "Dave",
            familyName: "Smith",
            fullName: "Dave Smith",
            email: "email@example.com",
            isVerified: true,
            isActive: true
        )
        let tokenPayload = TokenPayload(
            subject: userDTO.id.uuidString,
            email: "email@example.com",
            fullName: "Dave Smith",
            configuration: JWTConfiguration(
                issuer: "test",
                audience: "test",
                expiration: 1000
            ),
            dateProvider: { Date(timeIntervalSince1970: 0) }
        )
        authenticateUserUseCase.executeResult = .success(userDTO)
        tokenPayloadService.tokenPayloadResult = tokenPayload

        try await testWithApp(controller) { app in
            app.identityUseCases.use { _ in authenticateUserUseCase }
            app.identityServices.use { _ in tokenPayloadService }

            try await app.testing().test(
                .POST, "token",
                beforeRequest: { req in
                    try req.content.encode(userCredentialRequestModel)
                },
                afterResponse: { res async in
                    let tokenResponseModel = try? res.content.decode(TokenResponseModel.self)
                    let tokenData = tokenResponseModel?.token.data(using: .utf8) ?? Data()
                    let jwt = try? DefaultJWTParser().parse(tokenData, as: TokenPayload.self)

                    #expect(jwt?.payload == tokenPayload)
                }
            )
        }
    }

    @Test("token when request body is invalid throws bad request error")
    func tokenWhenRequestBodyIsInvalidReturnsBadRequest() async throws {
        authenticateUserUseCase.executeResult = .failure(.unknown())

        try await testWithApp(controller) { app in
            try await app.testing().test(
                .POST, "token",
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
        let userCredentialRequestModel = UserCredentialRequestModel(
            email: "email@example.com",
            password: "pass123"
        )
        authenticateUserUseCase.executeResult = .failure(.invalidEmailOrPassword)

        try await testWithApp(controller) { app in
            app.identityUseCases.use { _ in authenticateUserUseCase }

            try await app.testing().test(
                .POST, "token",
                beforeRequest: { req in
                    try req.content.encode(userCredentialRequestModel)
                },
                afterResponse: { res async in
                    #expect(res.status == .unauthorized)
                }
            )
        }
    }

}
