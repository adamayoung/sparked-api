//
//  MeController.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import AdamDateAuth
import IdentityApplication
import Vapor

struct MeController: RouteCollection, Sendable {

    struct Dependencies: Sendable {
        let fetchUserUseCase: @Sendable () -> any FetchUserUseCase

        package init(fetchUserUseCase: @escaping @Sendable () -> any FetchUserUseCase) {
            self.fetchUserUseCase = fetchUserUseCase
        }
    }

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func boot(routes: any RoutesBuilder) throws {
        routes.get("me", use: me)
    }

    @Sendable
    func me(req: Request) async throws -> UserResponseModel {
        let token = try await req.jwt.verify(as: TokenPayload.self)
        guard let userID = UUID(uuidString: token.subject.value) else {
            throw Abort(.forbidden)
        }

        let useCase = dependencies.fetchUserUseCase()
        let userDTO = try await useCase.execute(id: userID)

        let userResponseModel = UserResponseModelMapper.map(from: userDTO)
        return userResponseModel
    }

}
