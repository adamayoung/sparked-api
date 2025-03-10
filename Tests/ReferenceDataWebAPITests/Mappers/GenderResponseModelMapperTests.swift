//
//  GenderResponseModelMapperTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 06/02/2025.
//

import Foundation
import ReferenceDataApplication
import Testing

@testable import ReferenceDataWebAPI

@Suite("GenderResponseModelMapper")
struct GenderResponseModelMapperTests {

    @Test("map from country DTO with ID")
    func mapFromGenderWithID() throws {
        let id = try #require(UUID(uuidString: "9AC4BCE9-4151-4445-AD57-EA3BBC164355"))
        let dto = try Self.buildGenderDTO(id: id)

        let responseModel = GenderResponseModelMapper.map(from: dto)

        #expect(responseModel.id == id)
    }

    @Test("map from country DTO with code")
    func mapFromGenderWithCode() throws {
        let code = "F"
        let dto = try Self.buildGenderDTO(code: code)

        let responseModel = GenderResponseModelMapper.map(from: dto)

        #expect(responseModel.code == code)
    }

    @Test("map from country DTO with name")
    func mapFromGenderWithName() throws {
        let name = "Female"
        let dto = try Self.buildGenderDTO(name: name)

        let responseModel = GenderResponseModelMapper.map(from: dto)

        #expect(responseModel.name == name)
    }

}

extension GenderResponseModelMapperTests {

    private static func buildGenderDTO(
        id: UUID? = UUID(uuidString: "FCA157C1-65E8-43A5-840A-39CBC9BFACDB"),
        code: String = "M",
        name: String = "Male"
    ) throws -> GenderDTO {
        try GenderDTO(
            id: #require(id),
            code: code,
            name: name
        )
    }

}
