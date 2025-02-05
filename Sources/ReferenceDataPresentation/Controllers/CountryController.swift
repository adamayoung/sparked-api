//
//  CountryController.swift
//  AdamDateApp
//
//  Created by Adam Young on 05/02/2025.
//

import ReferenceDataApplication
import Vapor

package struct CountryController: RouteCollection, Sendable {

    private let fetchCountriesUseCase: @Sendable () -> any FetchCountriesUseCase

    package init(
        fetchCountriesUseCase: @escaping @Sendable () -> any FetchCountriesUseCase
    ) {
        self.fetchCountriesUseCase = fetchCountriesUseCase
    }

    package func boot(routes: any RoutesBuilder) throws {
        let countries = routes.grouped("countries")
        countries.get(use: index)
    }

    @Sendable
    func index(req: Request) async throws -> [CountryResponseModel] {
        let useCase = fetchCountriesUseCase()
        let countryDTOs = try await useCase.execute()
        let countryResponseModels = countryDTOs.map(CountryResponseModelMapper.map)

        return countryResponseModels
    }

}
