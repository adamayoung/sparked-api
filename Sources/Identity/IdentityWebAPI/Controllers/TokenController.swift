//
//  TokenController.swift
//  SparkedAPI
//
//  Created by Adam Young on 05/02/2025.
//

import AuthKit
import IdentityApplication
import Vapor

struct TokenController: RouteCollection, Sendable {

    func boot(routes: any RoutesBuilder) throws {
        routes.post("token", use: token)
            .description("Generate a JWT token for a user")
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
        let userDTO = try await req.authenticateUserUseCase.execute(credential: credential)
        let tokenPayload = req.tokenPayloadService.tokenPayload(for: userDTO)
        let signedToken = try await req.jwt.sign(tokenPayload)
        let tokenResponseModel = TokenResponseModel(token: signedToken)

        return tokenResponseModel
    }

}
