//
//  StarSignController.swift
//  AdamDateApp
//
//  Created by Adam Young on 18/03/2025.
//

import ReferenceDataApplication
import Vapor

struct StarSignController: RouteCollection, Sendable {

    func boot(routes: any RoutesBuilder) throws {
        routes.group("star-signs") { starSigns in
            starSigns.get(use: index)
                .description("Get all star signs")

            starSigns.get(":starSignID", use: show)
                .description("Get a star sign by ID")
        }
    }

    @Sendable
    func index(req: Request) async throws -> [StarSignResponseModel] {
        let starSignDTOs = try await req.fetchStarSignsUseCase.execute()
        let starSignResponseModels = starSignDTOs.map(StarSignResponseModelMapper.map)

        return starSignResponseModels
    }

    @Sendable
    func show(req: Request) async throws -> StarSignResponseModel {
        guard
            let starSignIDString = req.parameters.get("starSignID", as: String.self),
            let starSignID = UUID(uuidString: starSignIDString)
        else {
            throw Abort(.notFound)
        }

        let starSignDTO = try await req.fetchStarSignUseCase.execute(id: starSignID)
        let starSignResponseModel = StarSignResponseModelMapper.map(from: starSignDTO)

        return starSignResponseModel
    }

}
