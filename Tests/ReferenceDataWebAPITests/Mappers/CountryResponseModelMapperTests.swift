//
//  CountryResponseModelMapperTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 06/02/2025.
//

import Foundation
import ReferenceDataApplication
import Testing

@testable import ReferenceDataWebAPI

@Suite("CountryResponseModelMapper")
struct CountryResponseModelMapperTests {

    @Test("map from country DTO with ID")
    func mapFromCountryWithID() throws {
        let id = try #require(UUID(uuidString: "31037F6F-5F5B-45DB-B682-7FA6A4373BC9"))
        let dto = try Self.buildCountryDTO(id: id)

        let responseModel = CountryResponseModelMapper.map(from: dto)

        #expect(responseModel.id == id)
    }

    @Test("map from country DTO with code")
    func mapFromCountryWithCode() throws {
        let code = "GB"
        let dto = try Self.buildCountryDTO(code: code)

        let responseModel = CountryResponseModelMapper.map(from: dto)

        #expect(responseModel.code == code)
    }

    @Test("map from country DTO with name")
    func mapFromCountryWithName() throws {
        let name = "United Kingdom"
        let dto = try Self.buildCountryDTO(name: name)

        let responseModel = CountryResponseModelMapper.map(from: dto)

        #expect(responseModel.name == name)
    }

}

extension CountryResponseModelMapperTests {

    private static func buildCountryDTO(
        id: UUID? = UUID(uuidString: "0673FF7F-A477-4273-8155-49C9E990558A"),
        code: String = "GB",
        name: String = "United Kingdom"
    ) throws -> CountryDTO {
        try CountryDTO(
            id: #require(id),
            code: code,
            name: name
        )
    }

}
