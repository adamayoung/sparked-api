//
//  InterestController.swift
//  AdamDateApp
//
//  Created by Adam Young on 14/03/2025.
//

import ReferenceDataApplication
import Vapor

struct InterestController: RouteCollection, Sendable {

    func boot(routes: any RoutesBuilder) throws {
        routes.group("interest-groups", ":interestGroupID", "interests") { interests in
            interests.get(use: index)
                .description("Get all interests for a given interest group")

            interests.get(":interestID", use: show)
                .description("Get a given interest")
        }
    }

    @Sendable
    func index(req: Request) async throws -> [InterestResponseModel] {
        guard
            let interestGroupIDString = req.parameters.get("interestGroupID", as: String.self),
            let interestGroupID = UUID(uuidString: interestGroupIDString)
        else {
            throw Abort(.notFound)
        }

        let interestDTOs = try await req.fetchInterestsUseCase.execute(
            interestGroupID: interestGroupID)
        let interestResponseModels = interestDTOs.map(InterestResponseModelMapper.map)

        return interestResponseModels
    }

    @Sendable
    func show(req: Request) async throws -> InterestResponseModel {
        guard
            let interestGroupIDString = req.parameters.get("interestGroupID", as: String.self),
            let interestGroupID = UUID(uuidString: interestGroupIDString),
            let interestIDString = req.parameters.get("interestID", as: String.self),
            let interestID = UUID(uuidString: interestIDString)
        else {
            throw Abort(.notFound)
        }

        _ = try await req.fetchInterestGroupUseCase.execute(id: interestGroupID)

        let interestDTO = try await req.fetchInterestUseCase.execute(id: interestID)
        let interestResponseModel = InterestResponseModelMapper.map(from: interestDTO)

        return interestResponseModel
    }

}
