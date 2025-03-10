//
//  ReferenceDataResolver.swift
//  AdamDateApp
//
//  Created by Adam Young on 10/03/2025.
//

import Foundation
import ReferenceDataApplication
import Vapor

package protocol ReferenceDataResolver: Sendable {

    func fetchCountries(req: Request, args: FetchCountriesArguments) async throws -> [CountryDTO]

    func fetchGenders(req: Request, args: FetchGendersArguments) async throws -> [GenderDTO]

}

package struct FetchCountriesArguments: Codable {
    package let id: UUID?
}

package struct FetchGendersArguments: Codable {
    package let id: UUID?
}
