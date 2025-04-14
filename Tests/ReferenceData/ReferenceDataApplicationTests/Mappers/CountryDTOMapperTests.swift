//
//  CountryDTOMapperTests.swift
//  SparkedAPI
//
//  Created by Adam Young on 06/02/2025.
//

import Foundation
import ReferenceDataDomain
import Testing

@testable import ReferenceDataApplication

@Suite("CountryDTOMapper")
struct CountryDTOMapperTests {

    @Test("map from country with ID")
    func mapFromCountryWithID() throws {
        let id = try #require(UUID(uuidString: "31037F6F-5F5B-45DB-B682-7FA6A4373BC9"))
        let country = try Self.buildCountry(id: id)

        let dto = CountryDTOMapper.map(from: country)

        #expect(dto.id == id)
    }

    @Test("map from country with code")
    func mapFromCountryWithCode() throws {
        let code = "GB"
        let country = try Self.buildCountry(code: code)

        let dto = CountryDTOMapper.map(from: country)

        #expect(dto.code == code)
    }

    @Test("map from country with name")
    func mapFromCountryWithName() throws {
        let name = "United Kingdom"
        let country = try Self.buildCountry(name: name)

        let dto = CountryDTOMapper.map(from: country)

        #expect(dto.name == name)
    }

}

extension CountryDTOMapperTests {

    private static func buildCountry(
        id: UUID? = UUID(uuidString: "0673FF7F-A477-4273-8155-49C9E990558A"),
        code: String = "GB",
        name: String = "United Kingdom",
        nameKey: String = "UNITED_KINGDOM"
    ) throws -> Country {
        try Country(
            id: #require(id),
            code: code,
            name: name,
            nameKey: nameKey
        )
    }

}
