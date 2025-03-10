//
//  ReferenceDataUseCaseResolver.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import Foundation
import ReferenceDataApplication
import Vapor

final class ReferenceDataUseCaseResolver: ReferenceDataResolver {

    init() {}

    func fetchCountries(req: Request, args: FetchCountriesArguments) async throws -> [CountryDTO] {
        if let id = args.id {
            return try await [req.fetchCountryUseCase.execute(id: id)]
        }

        return try await req.fetchCountriesUseCase.execute()
    }

    func fetchGenders(req: Request, args: FetchGendersArguments) async throws -> [GenderDTO] {
        if let id = args.id {
            return try await [req.fetchGenderUseCase.execute(id: id)]
        }

        return try await req.fetchGendersUseCase.execute()
    }

}
