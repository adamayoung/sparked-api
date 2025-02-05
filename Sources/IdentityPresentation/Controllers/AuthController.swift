//
//  AuthController.swift
//  AdamDateApp
//
//  Created by Adam Young on 28/01/2025.
//

import AdamDateAuth
import IdentityApplication
import Vapor

package struct AuthController: RouteCollection, Sendable {

    private let registerUserUseCase: @Sendable () -> any RegisterUserUseCase
    private let authenticateUserUseCase: @Sendable () -> any AuthenticateUserUseCase
    private let fetchUserUseCase: @Sendable () -> any FetchUserUseCase
    private let tokenPayloadProvider: @Sendable () -> any TokenPayloadProvider

    package init(
        registerUserUseCase: @escaping @Sendable () -> any RegisterUserUseCase,
        authenticateUserUseCase: @escaping @Sendable () -> any AuthenticateUserUseCase,
        fetchUserUseCase: @escaping @Sendable () -> any FetchUserUseCase,
        tokenPayloadProvider: @escaping @Sendable () -> any TokenPayloadProvider
    ) {
        self.registerUserUseCase = registerUserUseCase
        self.authenticateUserUseCase = authenticateUserUseCase
        self.fetchUserUseCase = fetchUserUseCase
        self.tokenPayloadProvider = tokenPayloadProvider
    }

    package func boot(routes: any RoutesBuilder) throws {
        routes.post("register", use: register)
        routes.post("token", use: token)
        routes.get("me", use: me)
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
        let useCase = registerUserUseCase()
        try await useCase.execute(input: input)

        return .created
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

        let useCase = authenticateUserUseCase()
        let userDTO = try await useCase.execute(credential: credential)
        let tokenPayload = tokenPayloadProvider().tokenPayload(for: userDTO)
        let signedToken = try await req.jwt.sign(tokenPayload)

        let tokenResponseModel = TokenResponseModel(token: signedToken)
        return tokenResponseModel
    }

    @Sendable
    func me(req: Request) async throws -> UserResponseModel {
        let token = try await req.jwt.verify(as: TokenPayload.self)
        guard let userID = UUID(uuidString: token.subject.value) else {
            throw Abort(.forbidden)
        }

        let useCase = fetchUserUseCase()
        let userDTO = try await useCase.execute(id: userID)

        let userResponseModel = UserResponseModelMapper.map(from: userDTO)
        return userResponseModel
    }

}
