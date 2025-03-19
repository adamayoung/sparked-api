//
//  EducationLevelController.swift
//  AdamDateApp
//
//  Created by Adam Young on 18/03/2025.
//

import ReferenceDataApplication
import Vapor

struct EducationLevelController: RouteCollection, Sendable {

    func boot(routes: any RoutesBuilder) throws {
        routes.group("education-levels") { educationLevels in
            educationLevels.get(use: index)
                .description("Get all education levels")

            educationLevels.get(":educationLevelID", use: show)
                .description("Get a education level by ID")
        }
    }

    @Sendable
    func index(req: Request) async throws -> [EducationLevelResponseModel] {
        let educationLevelDTOs = try await req.fetchEducationLevelsUseCase.execute()
        let educationLevelResponseModels =
            educationLevelDTOs
            .map(EducationLevelResponseModelMapper.map)

        return educationLevelResponseModels
    }

    @Sendable
    func show(req: Request) async throws -> EducationLevelResponseModel {
        guard
            let educationLevelIDString = req.parameters.get("educationLevelID", as: String.self),
            let educationLevelID = UUID(uuidString: educationLevelIDString)
        else {
            throw Abort(.notFound)
        }

        let educationLevelDTO = try await req.fetchEducationLevelUseCase
            .execute(id: educationLevelID)
        let educationLevelResponseModel =
            EducationLevelResponseModelMapper
            .map(from: educationLevelDTO)

        return educationLevelResponseModel
    }

}
