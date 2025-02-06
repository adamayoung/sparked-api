//
//  GenderDTOMapperTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 06/02/2025.
//

import Foundation
import ReferenceDataDomain
import Testing

@testable import ReferenceDataApplication

@Suite("GenderDTOMapper")
struct GenderDTOMapperTests {

    @Test("map from gender with ID")
    func mapFromGenderWithID() throws {
        let id = try #require(UUID(uuidString: "D9BD9722-28F8-4E8A-ADB7-B96DBF040C10"))
        let gender = try Self.buildGender(id: id)

        let dto = GenderDTOMapper.map(from: gender)

        #expect(dto.id == id)
    }

    @Test("map from gender with code")
    func mapFromGenderWithCode() throws {
        let code = "F"
        let gender = try Self.buildGender(code: code)

        let dto = GenderDTOMapper.map(from: gender)

        #expect(dto.code == code)
    }

    @Test("map from gender with name")
    func mapFromGenderWithName() throws {
        let name = "Female"
        let gender = try Self.buildGender(name: name)

        let dto = GenderDTOMapper.map(from: gender)

        #expect(dto.name == name)
    }

}

extension GenderDTOMapperTests {

    private static func buildGender(
        id: UUID? = UUID(uuidString: "1526A301-B8D8-48EE-872F-93C310ABD689"),
        code: String = "M",
        name: String = "Male"
    ) throws -> Gender {
        try Gender(
            id: #require(id),
            code: code,
            name: name
        )
    }

}
