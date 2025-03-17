//
//  CountryController.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import ReferenceDataApplication
import Vapor

struct CountryController: RouteCollection, Sendable {

    func boot(routes: any RoutesBuilder) throws {
        let countries = routes.grouped("countries")
        countries.get(use: index)
            .description("Get all countries")

        countries.get(":countryID", use: show)
            .description("Get a country by ID")
    }

    @Sendable
    func index(req: Request) async throws -> [CountryResponseModel] {
        let countryDTOs = try await req.fetchCountriesUseCase.execute()
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

        let countryDTO = try await req.fetchCountryUseCase.execute(id: countryID)
        let countryResponseModel = CountryResponseModelMapper.map(from: countryDTO)

        return countryResponseModel
    }

}
