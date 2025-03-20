//
//  GenderMapperTests.swift
//  AdamDateApp
//
//  Created by Adam Young on 06/02/2025.
//

import Foundation
import ReferenceDataApplication
import Testing

@testable import ReferenceDataInfrastructure

@Suite("GenderMapper")
struct GenderMapperTests {

    @Test("map from gender with ID")
    func mapFromGenderWithID() throws {
        let id = try #require(UUID(uuidString: "D9BD9722-28F8-4E8A-ADB7-B96DBF040C10"))
        let model = GenderModel.mock(id: id)

        let gender = try GenderMapper.map(from: model)

        #expect(gender.id == id)
    }

    @Test("map from gender with code")
    func mapFromGenderWithCode() throws {
        let code = "F"
        let model = GenderModel.mock(code: code)

        let gender = try GenderMapper.map(from: model)

        #expect(gender.code == code)
    }

    @Test("map from gender with name")
    func mapFromGenderWithName() throws {
        let name = "Female"
        let model = GenderModel.mock(name: name)

        let gender = try GenderMapper.map(from: model)

        #expect(gender.name == name)
    }

}
