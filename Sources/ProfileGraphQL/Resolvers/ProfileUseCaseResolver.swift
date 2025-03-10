//
//  ProfileUseCaseResolver.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import AuthKit
import Foundation
import ProfileApplication
import Vapor

final class ProfileUseCaseResolver: ProfileResolver {

    init() {}

    func fetchBasicProfile(
        req: Request,
        args: FetchBasicProfileArguments
    ) async throws -> BasicProfileDTO {
        if let id = args.id {
            return try await req.fetchBasicProfileUseCase.execute(id: id)
        }

        let token = try await req.jwt.verify(as: TokenPayload.self)
        guard let userID = UUID(uuidString: token.subject.value) else {
            throw Abort(.forbidden)
        }

        return try await req.fetchBasicProfileUseCase.execute(userID: userID)
    }

}
