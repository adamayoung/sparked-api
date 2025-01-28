//
//  ProfileController.swift
//  AdamDateAPI
//
//  Created by Adam Young on 09/01/2025.
//

import AdamDateAuth
import JWT
import ProfileDomain
import ProfileEntities
import Vapor

package struct ProfileController: RouteCollection, Sendable {

    private let createProfileUseCase: @Sendable () -> any CreateBasicProfileUseCase
    private let fetchProfileUseCase: @Sendable () -> any FetchBasicProfileUseCase

    package init(
        createProfileUseCase: @escaping @Sendable () -> any CreateBasicProfileUseCase,
        fetchProfileUseCase: @escaping @Sendable () -> any FetchBasicProfileUseCase
    ) {
        self.createProfileUseCase = createProfileUseCase
        self.fetchProfileUseCase = fetchProfileUseCase
    }

    package func boot(routes: any RoutesBuilder) throws {
        let profiles = routes.grouped("profiles")
        profiles.get("me", use: showMe)
        profiles.get(":profileID", use: show)
        profiles.post(use: create)
    }

    @Sendable
    func showMe(req: Request) async throws -> ProfileDTO {
        let token = try await req.jwt.verify(as: TokenPayload.self)
        guard let userID = UUID(uuidString: token.subject.value) else {
            throw Abort(.forbidden)
        }

        let useCase = fetchProfileUseCase()
        let profile = try await useCase.execute(userID: userID)

        let dto = ProfileDTO(id: profile.id, displayName: profile.displayName)

        return dto
    }

    @Sendable
    func show(req: Request) async throws -> ProfileDTO {
        try await req.jwt.verify(as: TokenPayload.self)

        guard
            let profileIDString = req.parameters.get("profileID", as: String.self),
            let profileID = UUID(uuidString: profileIDString)
        else {
            throw Abort(.notFound)
        }

        let useCase = fetchProfileUseCase()
        let profile = try await useCase.execute(id: profileID)

        let dto = ProfileDTO(id: profile.id, displayName: profile.displayName)

        return dto
    }

    @Sendable
    func create(req: Request) async throws -> ProfileDTO {
        let token = try await req.jwt.verify(as: TokenPayload.self)
        guard let userID = UUID(uuidString: token.subject.value) else {
            throw Abort(.forbidden)
        }

        let createProfileDTO: CreateProfileDTO
        do {
            createProfileDTO = try req.content.decode(CreateProfileDTO.self)
        } catch {
            throw Abort(.badRequest, reason: "Request body is invalid")
        }

        let input = CreateBasicProfileInput(
            userID: userID,
            displayName: createProfileDTO.displayName,
            birthDate: createProfileDTO.birthDate
        )

        let useCase = createProfileUseCase()
        let profile = try await useCase.execute(input: input)

        let dto = ProfileDTO(
            id: profile.id,
            displayName: profile.displayName
        )

        return dto
    }

}
