//
//  CountryMapperTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 06/02/2025.
//

import Foundation
import ReferenceDataApplication
import Testing

@testable import ReferenceDataInfrastructure

@Suite("CountryMapper")
struct CountryMapperTests {

    @Test("map from country with ID")
    func mapFromCountryWithID() throws {
        let id = try #require(UUID(uuidString: "31037F6F-5F5B-45DB-B682-7FA6A4373BC9"))
        let model = try Self.buildCountryModel(id: id)

        let country = try CountryMapper.map(from: model)

        #expect(country.id == id)
    }

    @Test("map from country with code")
    func mapFromCountryWithCode() throws {
        let code = "GB"
        let model = try Self.buildCountryModel(code: code)

        let country = try CountryMapper.map(from: model)

        #expect(country.code == code)
    }

    @Test("map from country with name")
    func mapFromCountryWithName() throws {
        let name = "United Kingdom"
        let model = try Self.buildCountryModel(name: name)

        let country = try CountryMapper.map(from: model)

        #expect(country.name == name)
    }

}

extension CountryMapperTests {

    private static func buildCountryModel(
        id: UUID? = UUID(uuidString: "0673FF7F-A477-4273-8155-49C9E990558A"),
        code: String = "GB",
        name: String = "United Kingdom"
    ) throws -> CountryModel {
        try CountryModel(
            id: #require(id),
            code: code,
            name: name
        )
    }

}
