//
//  BasicProfileController.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import AdamDateAuth
import JWT
import ProfileApplication
import Vapor

struct BasicProfileController: RouteCollection, Sendable {

    func boot(routes: any RoutesBuilder) throws {
        routes.get("me", "basic", use: showMe)
        routes.get(":profileID", "basic", use: show)
        routes.post("me", "basic", use: create)
    }

    @Sendable
    func showMe(req: Request) async throws -> BasicProfileResponseModel {
        let token = try await req.jwt.verify(as: TokenPayload.self)
        guard let userID = UUID(uuidString: token.subject.value) else {
            throw Abort(.forbidden)
        }

        let basicProfileDTO = try await req.fetchBasicProfileUseCase.execute(userID: userID)
        let basicProfileResponseModel = BasicProfileResponseModelMapper.map(from: basicProfileDTO)

        return basicProfileResponseModel
    }

    @Sendable
    func show(req: Request) async throws -> BasicProfileResponseModel {
        try await req.jwt.verify(as: TokenPayload.self)
        guard
            let profileIDString = req.parameters.get("profileID", as: String.self),
            let profileID = UUID(uuidString: profileIDString)
        else {
            throw Abort(.notFound)
        }

        let basicProfileDTO = try await req.fetchBasicProfileUseCase.execute(id: profileID)
        let basicProfileResponseModel = BasicProfileResponseModelMapper.map(from: basicProfileDTO)

        return basicProfileResponseModel
    }

    @Sendable
    func create(req: Request) async throws -> BasicProfileResponseModel {
        let token = try await req.jwt.verify(as: TokenPayload.self)
        guard let userID = UUID(uuidString: token.subject.value) else {
            throw Abort(.forbidden)
        }

        let createBasicProfileRequestModel: CreateBasicProfileRequestModel
        do {
            createBasicProfileRequestModel = try req.content
                .decode(CreateBasicProfileRequestModel.self)
        } catch {
            throw Abort(.badRequest, reason: "Request body is invalid")
        }

        let input = CreateBasicProfileInputMapper.map(
            from: createBasicProfileRequestModel,
            userID: userID
        )
        let basicProfile = try await req.createBasicProfileUseCase.execute(input: input)
        let basicProfileResponseModel = BasicProfileResponseModelMapper.map(from: basicProfile)

        return basicProfileResponseModel
    }

}
