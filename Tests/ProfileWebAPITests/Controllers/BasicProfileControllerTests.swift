//
//  BasicProfileControllerTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 30/01/2025.
//

import APITesting
import AuthKit
import Foundation
import JWT
import ProfileApplication
import Testing
import VaporTesting

@testable import ProfileWebAPI

@Suite("BasicProfileController", .serialized)
struct BasicProfileControllerTests {

    let controller: BasicProfileController
    let createBasicProfileUseCase: CreateBasicProfileStubUseCase
    let fetchBasicProfileUseCase: FetchBasicProfileStubUseCase

    init() {
        self.createBasicProfileUseCase = CreateBasicProfileStubUseCase()
        self.fetchBasicProfileUseCase = FetchBasicProfileStubUseCase()
        self.controller = BasicProfileController()
    }

    @Test("show me when valid JWT token returns basic profile")
    func showMeWhenValidJWTTokenReturnsBasicProfile() async throws {
        let userID = try #require(UUID(uuidString: "84D74D2A-4368-4262-AEF8-067A6F1FE746"))
        let tokenPayload = try TokenPayload.stub(subject: userID)
        let basicProfileDTO = try Self.buildBasicProfileDTO(userID: userID)
        fetchBasicProfileUseCase.executeUserIDResult = .success(basicProfileDTO)
        let expectedResponseModel = BasicProfileResponseModelMapper.map(from: basicProfileDTO)

        try await testWithApp(controller, jwtPayload: tokenPayload) { app, jwt in
            app.profileUseCases.use { _ in fetchBasicProfileUseCase }

            try await app.testing().test(
                .GET, "me/basic",
                beforeRequest: { req in
                    if let jwt {
                        req.headers.bearerAuthorization = .init(token: jwt)
                    }
                },
                afterResponse: { res async throws in
                    #expect(res.status == .ok)
                    let responseModel = try res.content.decode(BasicProfileResponseModel.self)
                    #expect(responseModel == expectedResponseModel)
                    #expect(fetchBasicProfileUseCase.lastExecuteUserIDUserID == userID)
                }
            )
        }
    }

    @Test("show me when no JWT token throws unauthorized error")
    func showMeWhenNoJWTTokenThrowsUnauthorizedError() async throws {
        try await testWithApp(controller) { app in
            try await app.testing().test(
                .GET, "me/basic",
                afterResponse: { res async throws in
                    #expect(res.status == .unauthorized)
                }
            )
        }
    }

}

extension BasicProfileControllerTests {

    private static func buildBasicProfileDTO(
        id: UUID? = UUID(uuidString: "DE663275-F75E-4D6C-984F-8F3B0D637021"),
        userID: UUID? = UUID(uuidString: "94BBA546-05F6-4691-AB40-B39EA7B3E0F0"),
        displayName: String = "John",
        birthDate: Date = Date(timeIntervalSince1970: 0)
    ) throws -> BasicProfileDTO {
        try BasicProfileDTO(
            id: #require(id),
            userID: #require(userID),
            displayName: displayName,
            birthDate: birthDate,
            age: 40
        )
    }

}
