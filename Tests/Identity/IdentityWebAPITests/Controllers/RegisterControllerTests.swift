//
//  RegisterControllerTests.swift
//  SparkedAPI
//
//  Created by Adam Young on 05/02/2025.
//

import APITestingSupport
import Foundation
import IdentityApplication
import Testing
import VaporTesting

@testable import IdentityWebAPI

@Suite("RegisterController", .serialized)
struct RegisterControllerTests {

    let controller: RegisterController
    let registerUserUseCase: RegisterUserStubUseCase

    init() throws {
        self.registerUserUseCase = RegisterUserStubUseCase()
        self.controller = RegisterController()
    }

    @Test("register when request body is valid returns registered user")
    func registerWhenRequestBodyIsValidReturnsRegisteredUser() async throws {
        let registerUserRequestModel = RegisterUserRequestModel(
            firstName: "Dave",
            familyName: "Smith",
            email: "email@example.com",
            password: "pass123"
        )
        let userDTO = try UserDTO(
            id: #require(UUID(uuidString: "ABB41E11-03AB-4998-A349-9DE3FA859802")),
            firstName: "Dave",
            familyName: "Smith",
            fullName: "Dave Smith",
            email: "email@example.com",
            roles: [
                RoleDTO(
                    id: #require(UUID(uuidString: "13221120-6A7D-4FE2-8AAA-235F65B5E03D")),
                    code: "USER",
                    name: "User",
                    description: "User role"
                )
            ],
            isVerified: true,
            isActive: true
        )

        registerUserUseCase.executeResult = .success(userDTO)

        try await testWithApp(controller) { app in
            app.identityUseCases.use { _ in registerUserUseCase }

            try await app.testing().test(
                .POST, "register",
                beforeRequest: { req in
                    try req.content.encode(registerUserRequestModel)
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

        try await testWithApp(controller) { app in
            app.identityUseCases.use { _ in registerUserUseCase }

            try await app.testing().test(
                .POST, "register",
                beforeRequest: { req in
                    try req.content.encode("invalid-data")
                },
                afterResponse: { res async in
                    #expect(res.status == .badRequest)
                }
            )
        }
    }

}
