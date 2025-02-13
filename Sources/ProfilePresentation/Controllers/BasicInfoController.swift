//
//  BasicInfoController.swift
//  AdamDateApp
//
//  Created by Adam Young on 11/02/2025.
//

import AdamDateAuth
import JWT
import ProfileApplication
import Vapor

struct BasicInfoController: RouteCollection, Sendable {

    struct Dependencies {
        package let createBasicInfoUseCase: @Sendable () -> any CreateBasicInfoUseCase
        package let fetchBasicInfoUseCase: @Sendable () -> any FetchBasicInfoUseCase
        package let fetchBasicProfileUseCase: @Sendable () -> any FetchBasicProfileUseCase

        package init(
            createBasicInfoUseCase: @escaping @Sendable () -> any CreateBasicInfoUseCase,
            fetchBasicInfoUseCase: @escaping @Sendable () -> any FetchBasicInfoUseCase,
            fetchBasicProfileUseCase: @escaping @Sendable () -> any FetchBasicProfileUseCase
        ) {
            self.createBasicInfoUseCase = createBasicInfoUseCase
            self.fetchBasicInfoUseCase = fetchBasicInfoUseCase
            self.fetchBasicProfileUseCase = fetchBasicProfileUseCase
        }
    }

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func boot(routes: any RoutesBuilder) throws {
        routes.get("me", "info", use: showMe)
        routes.get(":profileID", "info", use: show)
        routes.post("me", "info", use: create)
    }

    @Sendable
    func showMe(req: Request) async throws -> BasicInfoResponseModel {
        let token = try await req.jwt.verify(as: TokenPayload.self)
        guard let userID = UUID(uuidString: token.subject.value) else {
            throw Abort(.forbidden)
        }

        let basicInfoDTO = try await dependencies.fetchBasicInfoUseCase()
            .execute(userID: userID)
        let basicInfoResponseModel = BasicInfoResponseModelMapper.map(from: basicInfoDTO)

        return basicInfoResponseModel
    }

    @Sendable
    func show(req: Request) async throws -> BasicInfoResponseModel {
        try await req.jwt.verify(as: TokenPayload.self)
        guard
            let profileIDString = req.parameters.get("profileID", as: String.self),
            let profileID = UUID(uuidString: profileIDString)
        else {
            throw Abort(.notFound)
        }

        let basicInfoDTO = try await dependencies.fetchBasicInfoUseCase()
            .execute(profileID: profileID)
        let basicInfoResponseModel = BasicInfoResponseModelMapper.map(from: basicInfoDTO)

        return basicInfoResponseModel
    }

    @Sendable
    func create(req: Request) async throws -> BasicInfoResponseModel {
        let token = try await req.jwt.verify(as: TokenPayload.self)
        guard let userID = UUID(uuidString: token.subject.value) else {
            throw Abort(.forbidden)
        }

        let basicProfileDTO = try await dependencies.fetchBasicProfileUseCase()
            .execute(userID: userID)

        let createBasicInfoRequestModel: CreateBasicInfoRequestModel
        do {
            createBasicInfoRequestModel = try req.content
                .decode(CreateBasicInfoRequestModel.self)
        } catch {
            throw Abort(.badRequest, reason: "Request body is invalid")
        }

        let input = CreateBasicInfoInputMapper.map(
            from: createBasicInfoRequestModel,
            userID: userID,
            profileID: basicProfileDTO.id
        )
        let basicInfo = try await dependencies.createBasicInfoUseCase()
            .execute(input: input)
        let basicInfoResponseModel = BasicInfoResponseModelMapper.map(from: basicInfo)

        return basicInfoResponseModel
    }

}
