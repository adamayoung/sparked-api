//
//  BasicInfoController.swift
//  AdamDateApp
//
//  Created by Adam Young on 11/02/2025.
//

import AuthKit
import JWT
import ProfileApplication
import Vapor

struct BasicInfoController: RouteCollection, Sendable {

    func boot(routes: any RoutesBuilder) throws {
        routes.get("me", "info", use: showMe)
            .description("Get basic information about the authenticated user")

        routes.get(":profileID", "info", use: show)
            .description("Get basic information about a user")

        routes.post("me", "info", use: create)
            .description("Create basic information about the authenticated user")
    }

    @Sendable
    func showMe(req: Request) async throws -> BasicInfoResponseModel {
        let token = try await req.jwt.verify(as: TokenPayload.self)
        guard let userID = UUID(uuidString: token.subject.value) else {
            throw Abort(.forbidden)
        }

        let basicInfoDTO = try await req.fetchBasicInfoUseCase.execute(userID: userID)
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

        let basicInfoDTO = try await req.fetchBasicInfoUseCase.execute(profileID: profileID)
        let basicInfoResponseModel = BasicInfoResponseModelMapper.map(from: basicInfoDTO)

        return basicInfoResponseModel
    }

    @Sendable
    func create(req: Request) async throws -> BasicInfoResponseModel {
        let token = try await req.jwt.verify(as: TokenPayload.self)
        guard let userID = UUID(uuidString: token.subject.value) else {
            throw Abort(.forbidden)
        }

        let basicProfileDTO = try await req.fetchBasicProfileUseCase.execute(userID: userID)

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
        let basicInfo = try await req.createBasicInfoUseCase.execute(input: input)
        let basicInfoResponseModel = BasicInfoResponseModelMapper.map(from: basicInfo)

        return basicInfoResponseModel
    }

}
