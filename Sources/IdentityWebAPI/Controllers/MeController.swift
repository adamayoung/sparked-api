//
//  MeController.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import AuthKit
import IdentityApplication
import Vapor

struct MeController: RouteCollection, Sendable {

    func boot(routes: any RoutesBuilder) throws {
        routes.get("me", use: me)
            .description("Get the current user")
    }

    @Sendable
    func me(req: Request) async throws -> UserResponseModel {
        let token = try await req.jwt.verify(as: TokenPayload.self)
        guard let userID = UUID(uuidString: token.subject.value) else {
            throw Abort(.forbidden)
        }

        let userDTO = try await req.fetchUserUseCase.execute(id: userID)
        let userResponseModel = UserResponseModelMapper.map(from: userDTO)

        return userResponseModel
    }

}
