//
//  BasicProfileController.swift
//  AdamDateApp
//
//  Created by Adam Young on 09/01/2025.
//

import AuthKit
import JWT
import ProfileApplication
import Vapor

struct BasicProfileController: RouteCollection, Sendable {

    func boot(routes: any RoutesBuilder) throws {
        routes.group("me", "basic") { meBasicProfile in
            meBasicProfile.get(use: showMe)
                .description("Get the basic profile of the authenticated user")

            meBasicProfile.post(use: createMe)
                .description("Create a new basic profile")
        }

        routes.group(":profileID", "basic") { basicProfile in
            basicProfile.get(use: show)
                .description("Get the basic profile of a user")
        }
    }

    @Sendable
    func showMe(req: Request) async throws -> BasicProfileResponseModel {
        let userContext = try await req.jwt.verify(as: TokenPayload.self)
        guard let userID = userContext.userID else {
            throw Abort(.forbidden)
        }

        let basicProfileDTO = try await req.fetchBasicProfileUseCase.execute(
            userID: userID,
            userContext: userContext
        )
        let basicProfileResponseModel = BasicProfileResponseModelMapper.map(from: basicProfileDTO)

        return basicProfileResponseModel
    }

    @Sendable
    func show(req: Request) async throws -> BasicProfileResponseModel {
        let userContext = try await req.jwt.verify(as: TokenPayload.self)
        guard
            let profileIDString = req.parameters.get("profileID", as: String.self),
            let profileID = UUID(uuidString: profileIDString)
        else {
            throw Abort(.notFound)
        }

        let basicProfileDTO = try await req.fetchBasicProfileUseCase.execute(
            id: profileID,
            userContext: userContext
        )
        let basicProfileResponseModel = BasicProfileResponseModelMapper.map(from: basicProfileDTO)

        return basicProfileResponseModel
    }

    @Sendable
    func createMe(req: Request) async throws -> BasicProfileResponseModel {
        let userContext = try await req.jwt.verify(as: TokenPayload.self)
        guard let userID = userContext.userID else {
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
        let basicProfile = try await req.createBasicProfileUseCase.execute(
            input: input,
            userContext: userContext
        )
        let basicProfileResponseModel = BasicProfileResponseModelMapper.map(from: basicProfile)

        return basicProfileResponseModel
    }

}
