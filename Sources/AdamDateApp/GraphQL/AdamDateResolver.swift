//
//  AdamDateResolver.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import Foundation
import ProfileApplication
import ProfileGraphQL
import ReferenceDataApplication
import ReferenceDataGraphQL
import Vapor

final class AdamDateResolver: Sendable {

    private let profileResolver: any ProfileResolver
    private let referenceDataResolver: any ReferenceDataResolver

    init(
        profileResolver: some ProfileResolver,
        referenceDataResolver: some ReferenceDataResolver
    ) {
        self.profileResolver = profileResolver
        self.referenceDataResolver = referenceDataResolver
    }

}

extension AdamDateResolver: ProfileResolver {

    func fetchBasicProfile(
        req: Request,
        args: FetchBasicProfileArguments
    ) async throws -> BasicProfileDTO {
        try await profileResolver.fetchBasicProfile(req: req, args: args)
    }

}

extension AdamDateResolver: ReferenceDataResolver {

    func fetchCountries(
        req: Request,
        args: FetchCountriesArguments
    ) async throws -> [CountryDTO] {
        try await referenceDataResolver.fetchCountries(req: req, args: args)
    }

    func fetchGenders(req: Request, args: FetchGendersArguments) async throws -> [GenderDTO] {
        try await referenceDataResolver.fetchGenders(req: req, args: args)
    }

}
