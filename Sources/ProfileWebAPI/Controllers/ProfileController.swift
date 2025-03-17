//
//  ProfileController.swift
//  AdamDateApp
//
//  Created by Adam Young on 12/02/2025.
//

import AuthKit
import JWT
import ProfileApplication
import Vapor

struct ProfileController: RouteCollection, Sendable {

    func boot(routes: any RoutesBuilder) throws {
        routes.get("me", use: showMe)
            .description("Get the current user's profile")

        routes.get(":profileID", use: show)
            .description("Get a user's profile")
    }

    @Sendable
    func showMe(req: Request) async throws -> ProfileResponseModel {
        let token = try await req.jwt.verify(as: TokenPayload.self)
        guard let userID = UUID(uuidString: token.subject.value) else {
            throw Abort(.forbidden)
        }

        let profileDTO = try await req.fetchProfileUseCase.execute(userID: userID)
        let profileResponseModel = ProfileResponseModelMapper.map(from: profileDTO)

        return profileResponseModel
    }

    @Sendable
    func show(req: Request) async throws -> ProfileResponseModel {
        try await req.jwt.verify(as: TokenPayload.self)
        guard
            let profileIDString = req.parameters.get("profileID", as: String.self),
            let profileID = UUID(uuidString: profileIDString)
        else {
            throw Abort(.notFound)
        }

        let profileDTO = try await req.fetchProfileUseCase.execute(id: profileID)
        let profileResponseModel = ProfileResponseModelMapper.map(from: profileDTO)

        return profileResponseModel
    }

}
