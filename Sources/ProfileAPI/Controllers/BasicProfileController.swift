//
//  BasicProfileController.swift
//  AdamDateAPI
//
//  Created by Adam Young on 09/01/2025.
//

import AdamDateAuth
import JWT
import ProfileDomain
import Vapor

package struct BasicProfileController: RouteCollection, Sendable {

    private let createBasicProfileUseCase: @Sendable () -> any CreateBasicProfileUseCase
    private let fetchBasicProfileUseCase: @Sendable () -> any FetchBasicProfileUseCase

    package init(
        createBasicProfileUseCase: @escaping @Sendable () -> any CreateBasicProfileUseCase,
        fetchBasicProfileUseCase: @escaping @Sendable () -> any FetchBasicProfileUseCase
    ) {
        self.createBasicProfileUseCase = createBasicProfileUseCase
        self.fetchBasicProfileUseCase = fetchBasicProfileUseCase
    }

    package func boot(routes: any RoutesBuilder) throws {
        let profiles = routes.grouped("profiles")
        profiles.get("me", "basic", use: showMe)
        profiles.get(":profileID", "basic", use: show)
        profiles.post("me", "basic", use: create)
    }

    @Sendable
    func showMe(req: Request) async throws -> BasicProfileDTO {
        let token = try await req.jwt.verify(as: TokenPayload.self)
        guard let userID = UUID(uuidString: token.subject.value) else {
            throw Abort(.forbidden)
        }

        let useCase = fetchBasicProfileUseCase()
        let profile = try await useCase.execute(userID: userID)
        let dto = BasicProfileDTOMapper.map(from: profile)

        return dto
    }

    @Sendable
    func show(req: Request) async throws -> BasicProfileDTO {
        try await req.jwt.verify(as: TokenPayload.self)
        guard
            let profileIDString = req.parameters.get("profileID", as: String.self),
            let profileID = UUID(uuidString: profileIDString)
        else {
            throw Abort(.notFound)
        }

        let useCase = fetchBasicProfileUseCase()
        let profile = try await useCase.execute(id: profileID)
        let dto = BasicProfileDTOMapper.map(from: profile)

        return dto
    }

    @Sendable
    func create(req: Request) async throws -> BasicProfileDTO {
        let token = try await req.jwt.verify(as: TokenPayload.self)
        guard let userID = UUID(uuidString: token.subject.value) else {
            throw Abort(.forbidden)
        }

        let createProfileDTO: CreateBasicProfileDTO
        do {
            createProfileDTO = try req.content.decode(CreateBasicProfileDTO.self)
        } catch {
            throw Abort(.badRequest, reason: "Request body is invalid")
        }

        let input = CreateBasicProfileInputMapper.map(from: createProfileDTO, userID: userID)
        let useCase = createBasicProfileUseCase()
        let profile = try await useCase.execute(input: input)
        let dto = BasicProfileDTOMapper.map(from: profile)

        return dto
    }

}
