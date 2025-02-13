//
//  RegisterController.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import IdentityApplication
import Vapor

struct RegisterController: RouteCollection, Sendable {

    struct Dependencies: Sendable {
        package let registerUserUseCase: @Sendable () -> any RegisterUserUseCase

        package init(registerUserUseCase: @escaping @Sendable () -> any RegisterUserUseCase) {
            self.registerUserUseCase = registerUserUseCase
        }
    }

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func boot(routes: any RoutesBuilder) throws {
        routes.post("register", use: register)
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
        let useCase = dependencies.registerUserUseCase()
        try await useCase.execute(input: input)

        return .created
    }

}
