//
//  TokenController.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import AdamDateAuth
import IdentityApplication
import Vapor

struct TokenController: RouteCollection, Sendable {

    struct Dependencies: Sendable {
        package let authenticateUserUseCase: @Sendable () -> any AuthenticateUserUseCase
        package let tokenPayloadProvider: @Sendable () -> any TokenPayloadProvider

        package init(
            authenticateUserUseCase: @escaping @Sendable () -> any AuthenticateUserUseCase,
            tokenPayloadProvider: @escaping @Sendable () -> any TokenPayloadProvider
        ) {
            self.authenticateUserUseCase = authenticateUserUseCase
            self.tokenPayloadProvider = tokenPayloadProvider
        }
    }

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func boot(routes: any RoutesBuilder) throws {
        routes.post("token", use: token)
    }

    @Sendable
    func token(req: Request) async throws -> TokenResponseModel {
        let userCredentialRequestModel: UserCredentialRequestModel
        do {
            userCredentialRequestModel = try req.content.decode(UserCredentialRequestModel.self)
        } catch {
            throw Abort(.badRequest, reason: "Request body is invalid")
        }

        let credential = UserCredentialMapper.map(from: userCredentialRequestModel)

        let useCase = dependencies.authenticateUserUseCase()
        let userDTO = try await useCase.execute(credential: credential)
        let tokenPayload = dependencies.tokenPayloadProvider().tokenPayload(for: userDTO)
        let signedToken = try await req.jwt.sign(tokenPayload)

        let tokenResponseModel = TokenResponseModel(token: signedToken)
        return tokenResponseModel
    }

}
