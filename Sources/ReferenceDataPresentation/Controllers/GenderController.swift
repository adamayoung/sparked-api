//
//  GenderController.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import ReferenceDataApplication
import Vapor

struct GenderController: RouteCollection, Sendable {

    struct Dependencies {
        let fetchGendersUseCase: @Sendable () -> any FetchGendersUseCase
        let fetchGenderUseCase: @Sendable () -> any FetchGenderUseCase

        init(
            fetchGendersUseCase: @escaping @Sendable () -> any FetchGendersUseCase,
            fetchGenderUseCase: @escaping @Sendable () -> any FetchGenderUseCase
        ) {
            self.fetchGendersUseCase = fetchGendersUseCase
            self.fetchGenderUseCase = fetchGenderUseCase
        }
    }

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func boot(routes: any RoutesBuilder) throws {
        let genders = routes.grouped("genders")
        genders.get(use: index)
        genders.get(":genderID", use: show)
    }

    @Sendable
    func index(req: Request) async throws -> [GenderResponseModel] {
        let useCase = dependencies.fetchGendersUseCase()
        let genderDTOs = try await useCase.execute()
        let genderResponseModels = genderDTOs.map(GenderResponseModelMapper.map)

        return genderResponseModels
    }

    @Sendable
    func show(req: Request) async throws -> GenderResponseModel {
        guard
            let genderIDString = req.parameters.get("genderID", as: String.self),
            let genderID = UUID(uuidString: genderIDString)
        else {
            throw Abort(.notFound)
        }

        let useCase = dependencies.fetchGenderUseCase()
        let genderDTO = try await useCase.execute(id: genderID)
        let genderResponseModel = GenderResponseModelMapper.map(from: genderDTO)

        return genderResponseModel
    }

}
