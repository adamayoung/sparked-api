//
//  AuthController.swift
//  AdamDateApp
//
//  Created by Adam Young on 28/01/2025.
//

import AdamDateAuth
import IdentityDomain
import IdentityEntities
import Vapor

package struct AuthController: RouteCollection, Sendable {

    package typealias RegisterUserUseCaseProvider = @Sendable () -> any RegisterUserUseCase
    package typealias AuthenticateUserUseCaseProvider = @Sendable () -> any AuthenticateUserUseCase
    package typealias FetchUserUseCaseProvider = @Sendable () -> any FetchUserUseCase

    private let registerUserUseCase: RegisterUserUseCaseProvider
    private let authenticateUserUseCase: AuthenticateUserUseCaseProvider
    private let fetchUserUseCase: FetchUserUseCaseProvider
    private let tokenPayloadProvider: @Sendable () -> any TokenPayloadProvider

    package init(
        registerUserUseCase: @escaping RegisterUserUseCaseProvider,
        authenticateUserUseCase: @escaping AuthenticateUserUseCaseProvider,
        fetchUserUseCase: @escaping FetchUserUseCaseProvider,
        tokenPayloadProvider: @escaping @Sendable () -> any TokenPayloadProvider
    ) {
        self.registerUserUseCase = registerUserUseCase
        self.authenticateUserUseCase = authenticateUserUseCase
        self.fetchUserUseCase = fetchUserUseCase
        self.tokenPayloadProvider = tokenPayloadProvider
    }

    package func boot(routes: any RoutesBuilder) throws {
        let auth = routes.grouped("auth")
        auth.post("register", use: register)
        auth.post("token", use: token)
        auth.get("me", use: me)
    }

    @Sendable
    func register(req: Request) async throws -> HTTPStatus {
        let registerUserDTO: RegisterUserDTO
        do {
            registerUserDTO = try req.content.decode(RegisterUserDTO.self)
        } catch {
            throw Abort(.badRequest, reason: "Request body is invalid")
        }

        let input = RegisterUserInputMapper.map(from: registerUserDTO)
        let useCase = registerUserUseCase()
        try await useCase.execute(input: input)

        return .created
    }

    @Sendable
    func token(req: Request) async throws -> TokenDTO {
        let userCredentialDTO: UserCredentialDTO
        do {
            userCredentialDTO = try req.content.decode(UserCredentialDTO.self)
        } catch {
            throw Abort(.badRequest, reason: "Request body is invalid")
        }

        let credential = UserCredentialMapper.map(from: userCredentialDTO)

        let useCase = authenticateUserUseCase()
        let user = try await useCase.execute(credential: credential)
        let tokenPayload = tokenPayloadProvider().tokenPayload(for: user)
        let signedToken = try await req.jwt.sign(tokenPayload)

        let tokenDTO = TokenDTO(token: signedToken)
        return tokenDTO
    }

    @Sendable
    func me(req: Request) async throws -> UserDTO {
        let token = try await req.jwt.verify(as: TokenPayload.self)
        guard let userID = UUID(uuidString: token.subject.value) else {
            throw Abort(.forbidden)
        }

        let useCase = fetchUserUseCase()
        let user = try await useCase.execute(id: userID)

        let dto = UserDTOMapper.map(from: user)
        return dto
    }

}
