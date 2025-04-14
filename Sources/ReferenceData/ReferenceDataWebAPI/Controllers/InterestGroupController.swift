//
//  InterestGroupController.swift
//  SparkedAPI
//
//  Created by Adam Young on 13/03/2025.
//

import ReferenceDataApplication
import Vapor

struct InterestGroupController: RouteCollection, Sendable {

    func boot(routes: any RoutesBuilder) throws {
        routes.group("interest-groups") { interestGroups in
            interestGroups.get(use: index)
                .description("Retrieves a list of interest groups")

            interestGroups.get(":interestGroupID", use: show)
                .description("Retrieves a single interest group")
        }
    }

    @Sendable
    func index(req: Request) async throws -> [InterestGroupResponseModel] {
        let query = try? req.query.decode(InterestGroupQuery.self)

        let interestGroupResponseModels: [InterestGroupResponseModel] = try await {
            if query?.include == .interests {
                let interestGroupDTOs = try await req.fetchInterestGroupsUseCase
                    .executeIncludingInterests()
                return interestGroupDTOs.map(InterestGroupResponseModelMapper.map)
            }

            let interestGroupDTOs = try await req.fetchInterestGroupsUseCase.execute()
            return interestGroupDTOs.map(InterestGroupResponseModelMapper.map)
        }()

        return interestGroupResponseModels
    }

    @Sendable
    func show(req: Request) async throws -> InterestGroupResponseModel {
        guard
            let interestGroupIDString = req.parameters.get("interestGroupID", as: String.self),
            let interestGroupID = UUID(uuidString: interestGroupIDString)
        else {
            throw Abort(.notFound)
        }

        let query = try? req.query.decode(InterestGroupQuery.self)

        let interestGroupResponseModel: InterestGroupResponseModel = try await {
            if query?.include == .interests {
                let interestGroupDTO = try await req.fetchInterestGroupUseCase
                    .executeIncludingInterests(id: interestGroupID)
                return InterestGroupResponseModelMapper.map(from: interestGroupDTO)
            }

            let interestGroupDTO = try await req.fetchInterestGroupUseCase
                .execute(id: interestGroupID)
            return InterestGroupResponseModelMapper.map(from: interestGroupDTO)
        }()

        return interestGroupResponseModel
    }

}

struct InterestGroupQuery: Content {

    let include: Include

    enum Include: String, Codable {
        case interests
    }

}
