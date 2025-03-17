//
//  RegisterController.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import IdentityApplication
import Vapor

struct RegisterController: RouteCollection, Sendable {

    func boot(routes: any RoutesBuilder) throws {
        routes.post("register", use: register)
            .description("Registers a new user")
    }

    @Sendable
    func register(req: Request) async throws -> HTTPStatus {
        let registerUserRequestModel: RegisterUserRequestModel
        do {
            registerUserRequestModel = try req.content.decode(RegisterUserRequestModel.self)
        } catch {
            throw Abort(.badRequest, reason: "Request body is invalid")
        }

        let input = RegisterUserInputMapper.map(from: registerUserRequestModel)
        try await req.registerUserUseCase.execute(input: input)

        return .created
    }

}
