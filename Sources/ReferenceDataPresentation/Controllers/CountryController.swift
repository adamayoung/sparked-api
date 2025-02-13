//
//  CountryController.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import ReferenceDataApplication
import Vapor

struct CountryController: RouteCollection, Sendable {

    struct Dependencies {
        let fetchCountriesUseCase: @Sendable () -> any FetchCountriesUseCase
        let fetchCountryUseCase: @Sendable () -> any FetchCountryUseCase

        init(
            fetchCountriesUseCase: @escaping @Sendable () -> any FetchCountriesUseCase,
            fetchCountryUseCase: @escaping @Sendable () -> any FetchCountryUseCase
        ) {
            self.fetchCountriesUseCase = fetchCountriesUseCase
            self.fetchCountryUseCase = fetchCountryUseCase
        }
    }

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func boot(routes: any RoutesBuilder) throws {
        let countries = routes.grouped("countries")
        countries.get(use: index)
        countries.get(":countryID", use: show)
    }

    @Sendable
    func index(req: Request) async throws -> [CountryResponseModel] {
        let useCase = dependencies.fetchCountriesUseCase()
        let countryDTOs = try await useCase.execute()
        let countryResponseModels = countryDTOs.map(CountryResponseModelMapper.map)

        return countryResponseModels
    }

    @Sendable
    func show(req: Request) async throws -> CountryResponseModel {
        guard
            let countryIDString = req.parameters.get("countryID", as: String.self),
            let countryID = UUID(uuidString: countryIDString)
        else {
            throw Abort(.notFound)
        }

        let useCase = dependencies.fetchCountryUseCase()
        let countryDTO = try await useCase.execute(id: countryID)
        let countryResponseModel = CountryResponseModelMapper.map(from: countryDTO)

        return countryResponseModel
    }

}
