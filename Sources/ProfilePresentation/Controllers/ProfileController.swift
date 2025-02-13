//
//  ProfileController.swift
//  AdamDateApp
//
//  Created by Adam Young on 12/02/2025.
//

import AdamDateAuth
import JWT
import ProfileApplication
import Vapor

struct ProfileController: RouteCollection, Sendable {

    struct Dependencies {
        package let fetchProfileUseCase: @Sendable () -> any FetchProfileUseCase

        package init(
            fetchProfileUseCase: @escaping @Sendable () -> any FetchProfileUseCase
        ) {
            self.fetchProfileUseCase = fetchProfileUseCase
        }
    }

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func boot(routes: any RoutesBuilder) throws {
        routes.get("me", use: showMe)
        routes.get(":profileID", use: show)
    }

    @Sendable
    func showMe(req: Request) async throws -> ProfileResponseModel {
        let token = try await req.jwt.verify(as: TokenPayload.self)
        guard let userID = UUID(uuidString: token.subject.value) else {
            throw Abort(.forbidden)
        }

        let profileDTO = try await dependencies.fetchProfileUseCase()
            .execute(userID: userID)

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

        let profileDTO = try await dependencies.fetchProfileUseCase()
            .execute(id: profileID)

        let profileResponseModel = ProfileResponseModelMapper.map(from: profileDTO)

        return profileResponseModel
    }

}
