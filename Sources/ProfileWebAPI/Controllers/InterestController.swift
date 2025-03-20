//
//  InterestController.swift
//  AdamDateApp
//
//  Created by Adam Young on 17/03/2025.
//

import AuthKit
import JWT
import ProfileApplication
import Vapor

struct InterestController: RouteCollection, Sendable {

    func boot(routes: any RoutesBuilder) throws {
        routes.group("me", "interests") { interests in
            interests.get(use: indexMe)
                .description("Get all interests of the authenticated user")

            interests.put(use: add)
                .description("Add an interest to profile of the authenticated user")

            interests.delete(":interestID", use: removeMe)
                .description("Remove an interest from profile of the authenticated user")
        }

        routes.group(":profileID", "interests") { interests in
            interests.get(use: index)
                .description("Get all interests of a given profile")

            interests.delete(":interestID", use: remove)
                .description("Remove an interest from profile of a given profile")
        }
    }

    @Sendable
    func index(req: Request) async throws -> [InterestResponseModel] {
        let userContext = try await req.jwt.verify(as: TokenPayload.self)
        guard
            let profileIDString = req.parameters.get("profileID", as: String.self),
            let profileID = UUID(uuidString: profileIDString)
        else {
            throw Abort(.notFound)
        }

        let profileInterestDTOs = try await req.fetchProfileInterestsUseCase.execute(
            profileID: profileID,
            userContext: userContext
        )

        let responseModels = profileInterestDTOs.map(InterestResponseModelMapper.map)

        return responseModels
    }

    @Sendable
    func indexMe(req: Request) async throws -> [InterestResponseModel] {
        let userContext = try await req.jwt.verify(as: TokenPayload.self)
        guard let userID = userContext.userID else {
            throw Abort(.forbidden)
        }

        let basicProfileDTO = try await req.fetchBasicProfileUseCase.execute(
            userID: userID,
            userContext: userContext
        )
        let profileInterestDTOs = try await req.fetchProfileInterestsUseCase.execute(
            profileID: basicProfileDTO.id,
            userContext: userContext
        )

        let responseModels = profileInterestDTOs.map(InterestResponseModelMapper.map)

        return responseModels
    }

    @Sendable
    func add(req: Request) async throws -> HTTPResponseStatus {
        let userContext = try await req.jwt.verify(as: TokenPayload.self)
        guard let userID = userContext.userID else {
            throw Abort(.forbidden)
        }

        let basicProfileDTO = try await req.fetchBasicProfileUseCase.execute(
            userID: userID,
            userContext: userContext
        )

        let addProfileInterestRequestModel: AddProfileInterestRequestModel
        do {
            addProfileInterestRequestModel = try req.content
                .decode(AddProfileInterestRequestModel.self)
        } catch {
            throw Abort(.badRequest, reason: "Request body is invalid")
        }

        let input = AddProfileInterestInputMapper.map(
            from: addProfileInterestRequestModel,
            profileID: basicProfileDTO.id
        )
        _ = try await req.addProfileInterestUseCase.execute(input: input, userContext: userContext)

        return .accepted
    }

    @Sendable
    func remove(req: Request) async throws -> HTTPResponseStatus {
        let userContext = try await req.jwt.verify(as: TokenPayload.self)
        guard let userID = userContext.userID else {
            throw Abort(.forbidden)
        }

        guard
            let profileIDString = req.parameters.get("profileID", as: String.self),
            let profileID = UUID(uuidString: profileIDString),
            let interestIDString = req.parameters.get("interestID", as: String.self),
            let interestID = UUID(uuidString: interestIDString)
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

        let input = RemoveProfileInterestInput(
            profileID: basicProfileDTO.id,
            interestID: interestID
        )
        try await req.removeProfileInterestUseCase.execute(input: input, userContext: userContext)

        return .accepted
    }

    @Sendable
    func removeMe(req: Request) async throws -> HTTPResponseStatus {
        let userContext = try await req.jwt.verify(as: TokenPayload.self)
        guard let userID = userContext.userID else {
            throw Abort(.forbidden)
        }

        let basicProfileDTO = try await req.fetchBasicProfileUseCase.execute(
            userID: userID,
            userContext: userContext
        )
        guard
            let interestIDString = req.parameters.get("interestID", as: String.self),
            let interestID = UUID(uuidString: interestIDString)
        else {
            throw Abort(.notFound)
        }

        let input = RemoveProfileInterestInput(
            profileID: basicProfileDTO.id,
            interestID: interestID
        )
        try await req.removeProfileInterestUseCase.execute(input: input, userContext: userContext)

        return .accepted
    }

}
