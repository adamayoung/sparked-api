//
//  ExtendedInfoController.swift
//  SparkedAPI
//
//  Created by Adam Young on 20/03/2025.
//

import AuthKit
import JWT
import ProfileApplication
import Vapor

struct ExtendedInfoController: RouteCollection, Sendable {

    func boot(routes: any RoutesBuilder) throws {
        routes.group("me", "extended-info") { meInfo in
            meInfo.get(use: showMe)
                .description("Get extended information about the authenticated user")

            meInfo.post(use: createMe)
                .description("Create basic information about the authenticated user")
        }

        routes.group(":profileID", "extended-info") { info in
            info.get(use: show)
                .description("Get extended information about a user")

            info.post(use: create)
                .description("Create basic information about a user")
        }
    }

    @Sendable
    func showMe(req: Request) async throws -> ExtendedInfoResponseModel {
        let userContext = try await req.jwt.verify(as: TokenPayload.self)
        guard let userID = userContext.userID else {
            throw Abort(.forbidden)
        }

        let extendedInfoDTO = try await req.fetchExtendedInfoUseCase.execute(
            userID: userID,
            userContext: userContext
        )
        let extendedInfoResponseModel = ExtendedInfoResponseModelMapper.map(from: extendedInfoDTO)

        return extendedInfoResponseModel
    }

    @Sendable
    func show(req: Request) async throws -> ExtendedInfoResponseModel {
        let userContext = try await req.jwt.verify(as: TokenPayload.self)
        guard
            let profileIDString = req.parameters.get("profileID", as: String.self),
            let profileID = UUID(uuidString: profileIDString)
        else {
            throw Abort(.notFound)
        }

        let extendedInfoDTO = try await req.fetchExtendedInfoUseCase.execute(
            profileID: profileID,
            userContext: userContext
        )
        let extendedInfoResponseModel = ExtendedInfoResponseModelMapper.map(from: extendedInfoDTO)

        return extendedInfoResponseModel
    }

    @Sendable
    func createMe(req: Request) async throws -> ExtendedInfoResponseModel {
        let userContext = try await req.jwt.verify(as: TokenPayload.self)
        guard let userID = userContext.userID else {
            throw Abort(.forbidden)
        }

        let basicProfileDTO = try await req.fetchBasicProfileUseCase.execute(
            userID: userID,
            userContext: userContext
        )

        let createExtendedInfoRequestModel: CreateExtendedInfoRequestModel
        do {
            createExtendedInfoRequestModel = try req.content
                .decode(CreateExtendedInfoRequestModel.self)
        } catch {
            throw Abort(.badRequest, reason: "Request body is invalid")
        }

        let input = CreateExtendedInfoInputMapper.map(
            from: createExtendedInfoRequestModel,
            profileID: basicProfileDTO.id
        )
        let extendedInfo = try await req.createExtendedInfoUseCase.execute(
            input: input,
            userContext: userContext
        )
        let extendedInfoResponseModel = ExtendedInfoResponseModelMapper.map(from: extendedInfo)

        return extendedInfoResponseModel
    }

    @Sendable
    func create(req: Request) async throws -> ExtendedInfoResponseModel {
        let userContext = try await req.jwt.verify(as: TokenPayload.self)
        guard let userID = userContext.userID else {
            throw Abort(.forbidden)
        }

        guard
            let profileIDString = req.parameters.get("profileID", as: String.self),
            let profileID = UUID(uuidString: profileIDString)
        else {
            throw Abort(.notFound)
        }

        let basicProfileDTO = try await req.fetchBasicProfileUseCase.execute(
            userID: userID,
            userContext: userContext
        )
        guard basicProfileDTO.id == profileID else {
            throw Abort(.forbidden)
        }

        let createExtendedInfoRequestModel: CreateExtendedInfoRequestModel
        do {
            createExtendedInfoRequestModel = try req.content
                .decode(CreateExtendedInfoRequestModel.self)
        } catch {
            throw Abort(.badRequest, reason: "Request body is invalid")
        }

        let input = CreateExtendedInfoInputMapper.map(
            from: createExtendedInfoRequestModel,
            profileID: basicProfileDTO.id
        )
        let extendedInfo = try await req.createExtendedInfoUseCase.execute(
            input: input,
            userContext: userContext
        )
        let extendedInfoResponseModel = ExtendedInfoResponseModelMapper.map(from: extendedInfo)

        return extendedInfoResponseModel
    }

}
